Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140318082553.GA1938@aemeltch-MOBL1>
References: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
	<1395061683-17206-3-git-send-email-luiz.dentz@gmail.com>
	<20140318082553.GA1938@aemeltch-MOBL1>
Date: Tue, 18 Mar 2014 10:53:17 +0200
Message-ID: <CABBYNZLq=3ey9_xQ0f+h-TH-QTQ4rL+B+V+AiM2X=qVa1tg=fw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 03/17] unit/test-avrcp: Fix test /TP/MPS/BV-02-C
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Mar 18, 2014 at 10:25 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi Luiz,
>
> On Mon, Mar 17, 2014 at 03:07:49PM +0200, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> The correct status should 0x04 not 0x00.
>> ---
>>  unit/test-avrcp.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
>> index 9fdbe6d..ed0c3fc 100644
>> --- a/unit/test-avrcp.c
>> +++ b/unit/test-avrcp.c
>> @@ -435,7 +435,10 @@ static int set_addressed(struct avrcp *session, uint8_t transaction,
>>  {
>>       DBG("");
>>
>> -     return 1;
>> +     avrcp_set_addressed_player_rsp(session, transaction,
>> +                                                     AVRCP_STATUS_SUCCESS);
>> +
>> +     return -EAGAIN;
>>  }
>>
>>  static const struct avrcp_control_ind control_ind = {
>> @@ -547,7 +550,7 @@ int main(int argc, char *argv[])
>>                       raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_STABLE,
>>                               0x48, 0x00, 0x00, 0x19, 0x58,
>>                               AVRCP_SET_ADDRESSED_PLAYER,
>> -                             0x00, 0x00, 0x01, 0x00));
>> +                             0x00, 0x00, 0x01, 0x04));
>
> I would put it                  0x00, 0x00, 0x01, AVRCP_STATUS_SUCCESS));

I prefer not to input defines in the raw PDU, the reason is that it
just gets in your way to debug what values are wrong when using
hexdump, also some defines that you are using such as PDU ids should
probably not be exposed now that we have proper functions mapping to
them.


-- 
Luiz Augusto von Dentz
