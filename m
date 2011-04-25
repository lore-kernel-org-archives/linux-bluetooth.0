Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <99B09243E1A5DA4898CDD8B7001114481086306D89@EXMB04.eu.tieto.com>
References: <1303372461-11848-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
	<1303372461-11848-6-git-send-email-waldemar.rymarkiewicz@tieto.com>
	<20110421081048.GA23120@jh-x301>
	<99B09243E1A5DA4898CDD8B7001114481086306D89@EXMB04.eu.tieto.com>
Date: Mon, 25 Apr 2011 20:09:54 +0300
Message-ID: <BANLkTi=B_54Zbgi8xz1RRwdVa9DgwayvAQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] Bluetooth: Respect local MITM req in io_cap reply
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Waldemar.Rymarkiewicz@tieto.com
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
	padovan@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Apr 21, 2011 at 11:24 AM,  <Waldemar.Rymarkiewicz@tieto.com> wrote:
> Hi Johan,
>
>>> --- a/net/bluetooth/hci_event.c
>>> +++ b/net/bluetooth/hci_event.c
>>> @@ -2369,7 +2369,7 @@ static inline u8 hci_get_auth_req(struct
>>> hci_conn *conn)
>>>
>>>      /* If remote requests no-bonding follow that lead */
>>>      if (conn->remote_auth == 0x00 || conn->remote_auth == 0x01)
>>> -            return 0x00;
>>> +            return conn->auth_type & 0x01;
>>>
>>>      return conn->auth_type;
>>>  }
>>
>>Your other patches seem ok to me, but have you verified this
>>one with the BITE tester? This logic is directly copied from
>>how it is in user space right now and that's something we have
>>arrived at after multiple iterations with the BITE tester over
>>the last few years. So I'd be very careful when changing it.
>>
>
> No, I did not. I don't have an access to BITE directly, but I will see if I can verify this.
>
> I simply did some combination of manual tests with three different dongles (2.0 and two 2.1), with sspmode on/off , with auth and encrypt on/off, with required sec_level 1,2,3 in security mode 2 and 4.

I remember we discussing something similar regarding LE security, iirc
this avoid failing in case there is not possible to generate an
authenticated key due to lack of io capability, but I also remember
that we do check what type of link key the kernel wants when reading
from storage and return not found when e.g authenticated key is
required but we have only unauthenticated, so perhaps this is just to
make sure we pass some specific BITE test.


-- 
Luiz Augusto von Dentz
Computer Engineer
