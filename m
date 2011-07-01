Return-Path: <cyrus@holtmann.org>
From: Arun Kumar SINGH <arunkr.singh@stericsson.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Bastien Nocera <hadess@hadess.net>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 1 Jul 2011 09:22:07 +0200
Subject: RE: [RFC BlueZ] Add Proximity API
Message-ID: <AFCDDB4A3EA003429EEF1E7B211FDBBA33A2BA4C12@EXDCVYMBSTM005.EQ1STM.local>
References: <1309458277-30407-1-git-send-email-claudio.takahasi@openbossa.org>
	<1309465011.5023.85.camel@novo.hadess.net>
 <BANLkTi=X__bC+4gAKuYzhvYPP-S3+QWGkw@mail.gmail.com>
In-Reply-To: <BANLkTi=X__bC+4gAKuYzhvYPP-S3+QWGkw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Anderson,

>>> Covers the Proximity Reporter for Link Loss, Tx Power and Immediate

[clip ...]

>> Is this
>> good enough to implement both sides of the profile, or just one side of
>> it?
>
>The API is for the Proximity Monitor role. 

Sounds bit confusing.. Ain't these API's being proposed for Proximity Reporter Role which is what Claudio mentioned in the original RFC? Which bring me to the next question- since a GATT client makes more sense for a dual mode stack such as Bluez, shouldn't we focus first on Monitor kind of roles for LE profiles and later consider Reporter type roles for testing only? 

>The Proximity Reporter role
>will usually run on LE single mode (very low power, coin cell battery)
>devices, but we will have a basic Proximity Reporter for testing
>purposes as well, which could be later expanded to a full featured
>Reporter.

>
>> Is this something that could require UI being written?
>
>For sure. This is just the D-Bus API, some graphical/console
>application must be written to use it. We will provide test scripts
>under the test/ directory.

Thanks,
Arun

