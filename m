Return-Path: <justin-qt-dated-1065700099.006603@affinix.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] dtl1_cs suspend bug
Date: Wed, 24 Sep 2003 20:35:48 -0700
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
References: <200309220408.04569.justin-qt@affinix.com>
	<200309232306.30064.justin-qt@affinix.com> <1064396202.1619.116.camel@pegasus>
In-Reply-To: <1064396202.1619.116.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309242035.48663.justin-qt@affinix.com>
From: Justin Karneges <justin-qt@affinix.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Wednesday 24 September 2003 02:36 am, Marcel Holtmann wrote:
> Maybe you should ask Socket for the specs of the Nokia card. Last time
> they send me a NDA which I can't accept. Now they have the Rev. G card
> on the market and these old cards are not built anymore. Maybe they make
> the specs public if someone asks. Put me on CC if you write to them.

I have written you privately about this.

By the way, I have found a simpler way to break the driver.  It seems that if 
I do 'hciconfig hci0 down', then 'hciconfig hci0 up' will hang.  This is 
without issuing any cardctl commands.  I'm not sure if this should be 
considered surprising.

-Justin
