Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <g2l2d5a2c101004270020mb94d092cnef88b98b147beba0@mail.gmail.com>
References: <t2m2c3916b71004261612i68ccba50h78c83ab3a02713cb@mail.gmail.com>
	 <g2l2d5a2c101004270020mb94d092cnef88b98b147beba0@mail.gmail.com>
Date: Tue, 27 Apr 2010 11:33:33 +0300
Message-ID: <n2h2d5a2c101004270133xa4ea7dd5za238a58f9e67613@mail.gmail.com>
Subject: Re: obexd OPP pull problem
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Daniel Abraham <daniel.shrugged@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Apr 27, 2010 at 10:20 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Tue, Apr 27, 2010 at 2:12 AM, Daniel Abraham
> <daniel.shrugged@gmail.com> wrote:
>> I'm trying to write a Python script that pulls a business card via OPP
>> (almost the same as the obexd test script "pull-business-card", except
>> it also handles pairing).
>>
>> My problem is that when I call the method "PullBusinessCard", it
>> returns almost immediately, withtout a D-Bus exception (i.e. should be
>> successful), but no output file can be found.
>>
>> Here's what I see in /var/log/messages:
>>
>> Apr 27 01:20:54 dabraham-mobl bluetoothd[1529]: link_key_request
>> (sba=00:21:86:7A:E7:67, dba=00:1C:26:FC:15:AF)
>> Apr 27 01:20:54 dabraham-mobl obex-client[3067]: Transfer(0xd4cb40)
>> Error: Method not allowed
>
> It should return a D-Bus error due to transfer error, which is why it
> doesn't complete the transfer, so it might be a bug in vcard pull
> logic, but why the transfer is failing  I don't know it shouldn't
> matter if you are paring or not.

This should fix at least the D-Bus error:

http://gitorious.org/obexd/vudentzs-clone/commit/32e48446b6b8cd72e15988c673a60c7fb47b0862

-- 
Luiz Augusto von Dentz
Computer Engineer
