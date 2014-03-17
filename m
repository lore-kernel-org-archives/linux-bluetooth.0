Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140317083837.GA16561@aemeltch-MOBL1>
References: <1395043737-8905-1-git-send-email-luiz.dentz@gmail.com>
	<20140317083837.GA16561@aemeltch-MOBL1>
Date: Mon, 17 Mar 2014 11:22:22 +0200
Message-ID: <CABBYNZL8Okni+ndvYUch80X5DkF4e4z-O86v00d_roS1JTOGEg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 01/12] android/avrcp-lib: Change API to register
 callbacks instead of PDU handlers
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Mar 17, 2014 at 10:38 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi Luiz,
>
> On Mon, Mar 17, 2014 at 10:08:46AM +0200, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This adds avrcp_register_player function to register callbacks for
>> requests and responses, the fundamental difference is that the
>> callbacks are called after the original PDU is parsed and the parameter
>> are converted to host byte order making us able to unit test the
>> parsing itself.
>> ---
>>  android/avrcp-lib.c | 27 +++++++++++++++++++++++++++
>>  android/avrcp-lib.h | 11 +++++++++++
>>  2 files changed, 38 insertions(+)
>>
>> diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
>> index 7b043ce..ca01b50 100644
>> --- a/android/avrcp-lib.c
>> +++ b/android/avrcp-lib.c
>> @@ -73,6 +73,7 @@ struct avrcp_header {
>>
>>  struct avrcp {
>>       struct avctp *conn;
>> +     struct avrcp_player *player;
>>
>>       size_t tx_mtu;
>>       uint8_t *tx_buf;
>> @@ -89,6 +90,13 @@ struct avrcp {
>>       void *destroy_data;
>>  };
>>
>> +struct avrcp_player {
>> +     const struct avrcp_control_ind *ind;
>> +     const struct avrcp_control_cfm *cfm;
>> +
>> +     void *user_data;
>> +};
>> +
>>  void avrcp_shutdown(struct avrcp *session)
>>  {
>>       if (session->conn) {
>> @@ -107,6 +115,7 @@ void avrcp_shutdown(struct avrcp *session)
>>       if (session->destroy)
>>               session->destroy(session->destroy_data);
>>
>> +     g_free(session->player);
>
> The player seems not allocated by default, so it should not be clean here.
> I would also make player_unregister() to make it consistent with
> player_register()

Well it is NULL by default which is handled by g_free, regarding
having a dedicated unregister function I thought about that but there
is no need to call it since currently it only support one player, but
perhaps if the player user_data needs to be freed without freeing the
whole session but I don't think I came across such use case.
