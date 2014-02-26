Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1393336605-2467-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393336605-2467-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Wed, 26 Feb 2014 13:59:30 +0200
Message-ID: <CABBYNZJXfxwxnN2DjKBKV9Ts=Npqc31f5VhcNC0qAjcqhSwUsw@mail.gmail.com>
Subject: Re: [PATCH 1/3] unit/avrcp: Add /TP/CFG/BV-01-C test
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Feb 25, 2014 at 3:56 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Test verifies that the get capabilities command issued from the
> Controller. For that we add the command to avrcp-lib and it will be used
> in AVRCP later.
> ---
>  android/avrcp-lib.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  android/avrcp-lib.h |  2 ++
>  android/avrcp.c     |  1 +
>  unit/test-avrcp.c   | 17 +++++++++++++++++
>  4 files changed, 60 insertions(+)
>
> diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
> index c280cf8..136801e 100644
> --- a/android/avrcp-lib.c
> +++ b/android/avrcp-lib.c
> @@ -50,6 +50,12 @@
>  #define AVRCP_STATUS_NO_AVAILABLE_PLAYERS      0x15
>  #define AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED  0x16
>
> +/* Packet types */
> +#define AVRCP_PACKET_TYPE_SINGLE       0x00
> +#define AVRCP_PACKET_TYPE_START                0x01
> +#define AVRCP_PACKET_TYPE_CONTINUING   0x02
> +#define AVRCP_PACKET_TYPE_END          0x03
> +
>  #if __BYTE_ORDER == __LITTLE_ENDIAN
>
>  struct avrcp_header {
> @@ -202,6 +208,18 @@ static bool handle_passthrough_pdu(struct avctp *conn, uint8_t op,
>         return handler->func(session);
>  }
>
> +/*
> + * set_company_id:
> + *
> + * Set three-byte Company_ID into outgoing AVRCP message
> + */
> +static void set_company_id(uint8_t cid[3], const uint32_t cid_in)
> +{
> +       cid[0] = cid_in >> 16;
> +       cid[1] = cid_in >> 8;
> +       cid[2] = cid_in;
> +}

Check out what I did with ntoh24, you need to check the byte order as
well and create hton24.

>  struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
>  {
>         struct avrcp *session;
> @@ -253,3 +271,25 @@ int avrcp_init_uinput(struct avrcp *session, const char *name,
>  {
>         return avctp_init_uinput(session->conn, name, address);
>  }
> +
> +#define AVRCP_GET_CAPABILITIES_PARAM_LENGTH 1
> +void avrcp_get_capabilities(struct avrcp *session, avctp_rsp_cb func)
> +{
> +       uint8_t buf[AVRCP_HEADER_LENGTH + AVRCP_GET_CAPABILITIES_PARAM_LENGTH];
> +       struct avrcp_header *pdu = (void *) buf;
> +       uint8_t length;
> +
> +       memset(buf, 0, sizeof(buf));
> +
> +       set_company_id(pdu->company_id, IEEEID_BTSIG);
> +       pdu->pdu_id = AVRCP_GET_CAPABILITIES;
> +       pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
> +       pdu->params[0] = CAP_EVENTS_SUPPORTED;
> +       pdu->params_len = htons(AVRCP_GET_CAPABILITIES_PARAM_LENGTH);
> +
> +       length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
> +
> +       avctp_send_vendordep_req(session->conn, AVC_CTYPE_STATUS,
> +                                       AVC_SUBUNIT_PANEL, buf, length,
> +                                       func, session);
> +}

I would create a helper function called avrc_send_req which takes the
callback + params and params_len, also Im not sure if it is a good
idea to reuse avctp_rsp_cb or have a different callback so we can
treat AVCTP internally.

> diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
> index 2337429..4f3a632 100644
> --- a/android/avrcp-lib.h
> +++ b/android/avrcp-lib.h
> @@ -74,3 +74,5 @@ void avrcp_set_passthrough_handlers(struct avrcp *session,
>                         void *user_data);
>  int avrcp_init_uinput(struct avrcp *session, const char *name,
>                                                         const char *address);
> +
> +void avrcp_get_capabilities(struct avrcp *session, avctp_rsp_cb func);
> diff --git a/android/avrcp.c b/android/avrcp.c
> index 48444a4..3d39d91 100644
> --- a/android/avrcp.c
> +++ b/android/avrcp.c
> @@ -36,6 +36,7 @@
>  #include "bluetooth.h"
>  #include "hal-msg.h"
>  #include "ipc.h"
> +#include "avctp.h"
>  #include "avrcp-lib.h"
>  #include "avrcp.h"
>
> diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
> index 53e9237..4a92860 100644
> --- a/unit/test-avrcp.c
> +++ b/unit/test-avrcp.c
> @@ -297,6 +297,16 @@ static void test_server(gconstpointer data)
>         execute_context(context);
>  }
>
> +static void test_client(gconstpointer data)
> +{
> +       struct context *context = create_context(0x0100, data);
> +
> +       if (g_str_equal(context->data->test_name, "/TP/CFG/BV-01-C"))
> +               avrcp_get_capabilities(context->session, NULL);
> +
> +       execute_context(context);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>         g_test_init(&argc, &argv, NULL);
> @@ -364,5 +374,12 @@ int main(int argc, char *argv[])
>                         raw_pdu(0x02, 0x11, 0x0e, 0x09, 0x48, 0x7c,
>                                 AVC_PLAY | 0x80, 0x00));
>
> +       /* Metadata transfer tests */
> +
> +       define_test("/TP/CFG/BV-01-C", test_client,
> +                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> +                               0x00, 0x19, 0x58, 0x10, 0x00, 0x00,
> +                               0x01, 0x03));
> +
>         return g_test_run();
>  }
> --
> 1.8.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
