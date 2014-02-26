Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Feb 2014 14:22:50 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/3] unit/avrcp: Add /TP/CFG/BV-01-C test
Message-ID: <20140226122109.GB27308@aemeltch-MOBL1>
References: <1393336605-2467-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CABBYNZJXfxwxnN2DjKBKV9Ts=Npqc31f5VhcNC0qAjcqhSwUsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZJXfxwxnN2DjKBKV9Ts=Npqc31f5VhcNC0qAjcqhSwUsw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Feb 26, 2014 at 01:59:30PM +0200, Luiz Augusto von Dentz wrote:
> Hi Andrei,
> 
> On Tue, Feb 25, 2014 at 3:56 PM, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > Test verifies that the get capabilities command issued from the
> > Controller. For that we add the command to avrcp-lib and it will be used
> > in AVRCP later.
> > ---
> >  android/avrcp-lib.c | 40 ++++++++++++++++++++++++++++++++++++++++
> >  android/avrcp-lib.h |  2 ++
> >  android/avrcp.c     |  1 +
> >  unit/test-avrcp.c   | 17 +++++++++++++++++
> >  4 files changed, 60 insertions(+)
> >
> > diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
> > index c280cf8..136801e 100644
> > --- a/android/avrcp-lib.c
> > +++ b/android/avrcp-lib.c
> > @@ -50,6 +50,12 @@
> >  #define AVRCP_STATUS_NO_AVAILABLE_PLAYERS      0x15
> >  #define AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED  0x16
> >
> > +/* Packet types */
> > +#define AVRCP_PACKET_TYPE_SINGLE       0x00
> > +#define AVRCP_PACKET_TYPE_START                0x01
> > +#define AVRCP_PACKET_TYPE_CONTINUING   0x02
> > +#define AVRCP_PACKET_TYPE_END          0x03
> > +
> >  #if __BYTE_ORDER == __LITTLE_ENDIAN
> >
> >  struct avrcp_header {
> > @@ -202,6 +208,18 @@ static bool handle_passthrough_pdu(struct avctp *conn, uint8_t op,
> >         return handler->func(session);
> >  }
> >
> > +/*
> > + * set_company_id:
> > + *
> > + * Set three-byte Company_ID into outgoing AVRCP message
> > + */
> > +static void set_company_id(uint8_t cid[3], const uint32_t cid_in)
> > +{
> > +       cid[0] = cid_in >> 16;
> > +       cid[1] = cid_in >> 8;
> > +       cid[2] = cid_in;
> > +}
> 
> Check out what I did with ntoh24, you need to check the byte order as
> well and create hton24.
> 
> >  struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
> >  {
> >         struct avrcp *session;
> > @@ -253,3 +271,25 @@ int avrcp_init_uinput(struct avrcp *session, const char *name,
> >  {
> >         return avctp_init_uinput(session->conn, name, address);
> >  }
> > +
> > +#define AVRCP_GET_CAPABILITIES_PARAM_LENGTH 1
> > +void avrcp_get_capabilities(struct avrcp *session, avctp_rsp_cb func)
> > +{
> > +       uint8_t buf[AVRCP_HEADER_LENGTH + AVRCP_GET_CAPABILITIES_PARAM_LENGTH];
> > +       struct avrcp_header *pdu = (void *) buf;
> > +       uint8_t length;
> > +
> > +       memset(buf, 0, sizeof(buf));
> > +
> > +       set_company_id(pdu->company_id, IEEEID_BTSIG);
> > +       pdu->pdu_id = AVRCP_GET_CAPABILITIES;
> > +       pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
> > +       pdu->params[0] = CAP_EVENTS_SUPPORTED;
> > +       pdu->params_len = htons(AVRCP_GET_CAPABILITIES_PARAM_LENGTH);
> > +
> > +       length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
> > +
> > +       avctp_send_vendordep_req(session->conn, AVC_CTYPE_STATUS,
> > +                                       AVC_SUBUNIT_PANEL, buf, length,
> > +                                       func, session);
> > +}
> 
> I would create a helper function called avrc_send_req which takes the
> callback + params and params_len, also Im not sure if it is a good
> idea to reuse avctp_rsp_cb or have a different callback so we can
> treat AVCTP internally.

So avrcp_send_req does not really help here since it would be just wrapper
for avctp_send functions. Maybe then this unit test is not needed at all?

Best regards 
Andrei Emeltchenko 

