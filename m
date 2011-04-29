Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <johan.hedberg@gmail.com>, <padovan@profusion.mobi>,
	<linux-bluetooth@vger.kernel.org>
Date: Fri, 29 Apr 2011 11:30:56 +0300
Subject: RE: [PATCH v3 5/7] Bluetooth: Double check sec req for pre 2.1
 device
Message-ID: <99B09243E1A5DA4898CDD8B70011144816F29AEEA7@EXMB04.eu.tieto.com>
References: <1303985279-3944-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1303985279-3944-6-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20110428181117.GA11610@jh-x301> <20110428210852.GA25436@jh-x301>
In-Reply-To: <20110428210852.GA25436@jh-x301>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan,

>Never mind. d->sec_level is obviously the security requirement 
>for the RFCOMM link which could be different from the current 
>ACL security level. Nevertheless, I think instead of doing the 
>complicated if-statement on the key_type & pin_length you can 
>simply check the value of conn->sec_level.
>

I agree. Will update and send again.

Waldek