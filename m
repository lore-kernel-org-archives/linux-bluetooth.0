Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140312140200.GA28725@aemeltch-MOBL1>
References: <1394630342-32469-1-git-send-email-luiz.dentz@gmail.com>
	<20140312140200.GA28725@aemeltch-MOBL1>
Date: Wed, 12 Mar 2014 17:22:58 +0200
Message-ID: <CABBYNZLqm57xuTfQYoJkhAFm5P3VLOeVqA=3rNhY6QCBCXeCKw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] android/avrcp-lib: Change API to register callbacks
 instead of PDU handlers
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Mar 12, 2014 at 4:02 PM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi Luiz,
>
> On Wed, Mar 12, 2014 at 03:19:02PM +0200, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This adds avrcp_register_player function to register callbacks for
>> requests and responses, the fundamental difference is that the
>> callbacks are called after the original PDU is parsed and the parameter
>> are converted to host byte order making us able to unit test the
>> parsing itself.
>> ---
>>  android/avrcp-lib.c | 23 +++++++++++++++++
>>  android/avrcp-lib.h | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 96 insertions(+)
>>
>> diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
>> index befc404..953674b 100644
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
>> @@ -249,6 +257,21 @@ void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
>>       session->destroy_data = user_data;
>>  }
>>
>> +void avrcp_register_player(struct avrcp *session,
>> +                             const struct avrcp_control_ind *ind,
>> +                             const struct avrcp_control_cfm *cfm,
>> +                             void *user_data)
>> +{
>> +     struct avrcp_player *player;
>> +
>> +     player = g_new0(struct avrcp_player, 1);
>
> where do you free it?

Most likely with the session, this is not the complete implementation
just an idea.
