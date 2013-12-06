Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20131128165916.GA21429@molly.amr.corp.intel.com>
References: <CAHZ1yC=Tx=4zRL_rV0-b-sqhQCO=AmXzCy93Q5jnb2=z2Kr6KQ@mail.gmail.com>
	<20131128165916.GA21429@molly.amr.corp.intel.com>
Date: Fri, 6 Dec 2013 11:47:25 -0800
Message-ID: <CAHZ1yCmSBbdEtuDOHcB21MdHxVd=jjE51C15SJAaUE9Q6xGBTQ@mail.gmail.com>
Subject: Re: SM: is BlueZ the Master/Initiator or Slave/Responder?
From: Scott James Remnant <keybuk@google.com>
To: Vinicius Costa Gomes <vcgomes@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Holtmann, Marcel" <marcel.holtmann@intel.com>,
	Johan Hedberg <johan.hedberg@intel.com>,
	Brian Gix <bgix@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Great, sounds like I came to the right conclusion myself - after
reading the spec and examining the test case, we couldn't find a
reason to set this bit unless BlueZ can also behave as the Slave,
which is not only something we didn't expect it to do, but also not
something we had claimed in the PICS.

I filed a TSE with the SIG on 11/25 and it looks like they agree too,
and that this test should only be used when a IUT specifies that it
supports both the Master and Slave role, so looks like the TSE will be
approved along with the matching TCW.

Scott

On Thu, Nov 28, 2013 at 8:59 AM, Vinicius Costa Gomes <vcgomes@gmail.com> wrote:
> Hi Scott,
>
> On 13:17 Mon 25 Nov, Scott James Remnant wrote:
>> We are able to pass all qualification tests with BlueZ as the Master except one:
>>
>>   TP/KDU/BV-06-C - Master Key Distribution - Encryption Key bit
>>
>> This test requires that BlueZ initiates pairing with the
>> SMP_DIST_ENC_KEY bit set in the init_key_dist member of struct
>> smp_cmd_pairing - however this member is always initialized to zero
>> and never changed.
>
> This test is in theory correct, but it doesn't test anything that does make
> sense at this point. Let me try to explain, setting the Encryption Key bit in
> the initiator key distribution field in the Pairing Request means that the
> Initiator wants to send its Encryption Key to the Responder.
>
> This is only useful in cases that both devices expect the roles to be reversed
> in future connections (The Master of this connection would become the Slave in
> future connections). And IIRC we weren't able to test this role reversal and
> it even offends the current GAP spec for Dual mode devices.
>
>>
>> This seems to have changed at some point in the past, 2b64d153 added
>> MITM mechanism and changed the init_key_dist member initialization
>> from dist_keys to 0
>>
>>
>> So two questions:
>>
>>  1) should BlueZ be able to behave as Master? It passes the majority
>> of the tests except this one.
>
> BlueZ should be able to bahave as Master, if not, it is a bug.
>
>>
>>  2) given the above, is this a bug that init_key_dist is 0 or is it a
>> test plan error that it requires this?
>
> I think it is a bit of both, for the current situation the Master distributing
> its keys doesn't make much sense and we should be able to change this value to
> be able to test the key distribution parts.
>
> What I suggest is adding a debugfs entry to change the value of init_key_dist
> for Pairing Requests, and keep the default being 0.
>
> (disclaimer: I am follwing development from the sidelines for some time, so
> feel free to correct me.)
>
>>
>> Scott
>> --
>> Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> Cheers,
> --
> Vinicius



-- 
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
