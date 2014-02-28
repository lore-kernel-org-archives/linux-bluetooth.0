Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: Receiving data in BLE non-connectable undirected advertisements
From: Adam Warski <adam@warski.org>
In-Reply-To: <5310AD83.9030208@gmx.net>
Date: Fri, 28 Feb 2014 16:54:59 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <E4D1FACB-475A-44B0-B20F-A9CBB250FF2C@warski.org>
References: <5310A4A9.2000907@gmx.net> <00B030ED-78C3-4C48-B738-4161348CD6E8@warski.org> <5310AD83.9030208@gmx.net>
To: Benjamin Adler <benadler@gmx.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> Also, only the first advertisement of the SensorTag is shown. While that probably makes sense for traditional advertisements, my use case requires that all advertisements are shown, as I'm trying to transmit low-rate data from the tag's sensors in the advertisements.

Try hcitool lescan --duplicates.
By default duplicates are filtered out, so as all the advertisements are the same, you only see the first one after starting scanning.

However, see my post from 3 hours ago, I get into buffer overflows errors when using this option (but maybe it’s only me :) )

Adam

-- 
Adam Warski

http://twitter.com/#!/adamwarski
http://www.softwaremill.com
http://www.warski.org

