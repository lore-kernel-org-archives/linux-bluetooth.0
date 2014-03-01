Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: Passive scanning of iBeacons results in a "Data Buffer Overflow"
From: Adam Warski <adam@warski.org>
In-Reply-To: <CAJdJm_PMAVyiY-=13puBHAucCzObUWOSOXZ+maOL2z11YwOh-g@mail.gmail.com>
Date: Sat, 1 Mar 2014 10:34:47 +0100
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <A4DDF6F3-8DD4-4CF7-A5C0-205F5B4EE489@warski.org>
References: <6E6C1573-4744-486B-B2E6-2D3DC45D024B@warski.org> <CAJdJm_PMAVyiY-=13puBHAucCzObUWOSOXZ+maOL2z11YwOh-g@mail.gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> For me looks like something got confused on the HCI packet parsing:
> either the kernel, hcidump, or something else. The HCI events after
> the LE meta event make no sense (they seem garbage). Did you try with
> btmon instead of hcidump ?

Yes, with btmon the same is happening. Also when just running “hcitool lescan --passive —duplicates” it stops getting advertisements after a while (without hcidump or btmon running in the background).

> Can you save the raw dump using "hcidump -w output.dump"  (or using
> btmon -w) and send to the list? It is easier to analyze, as the parser
> may be bogus.

Sure. The problems start at 63.120548.
The dump is here: http://www.warski.org/btmon_ibeacons.dat

Thanks,
Adam

-- 
Adam Warski

http://twitter.com/#!/adamwarski
http://www.softwaremill.com
http://www.warski.org

