Return-Path: <cyrus@holtmann.org>
Subject: Re: Volume control for headset
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Davies <nickavies@yahoo.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Iain Hibbert <plunky@rya-online.net>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <486561.68367.qm@web112806.mail.gq1.yahoo.com>
References: <418098.94079.qm@web112804.mail.gq1.yahoo.com>
	 <1253864301.981724.225.nullmailer@galant.ukfsn.org>
	 <807937.34864.qm@web112809.mail.gq1.yahoo.com>
	 <20090925105441.GA19339@jh-x301>
	 <486561.68367.qm@web112806.mail.gq1.yahoo.com>
Content-Type: text/plain
Date: Fri, 25 Sep 2009 06:14:43 -0700
Message-Id: <1253884483.2931.21.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

so first of all this mailing list does NOT allow top posting. So don't
do it.

>   I'd like to provide you more details about my current situation: 
>   I download the btsco-5.0 , use the old bt-sco module and daemon to connect the headset with my PC, then I can hear the sound from my headset, but it's not available to control the volume from my PC.  So I start to debug this issue.

And this is where you are using old and deprecated software. btsco and
its kernel module is and actually never was supported. Use the method
Johan described.

Regards

Marcel


