Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Apr 2012 14:41:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vishal AGARWAL <vishal.agarwal@stericsson.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Naresh-kumar GUPTA <naresh.gupta@stericsson.com>
Subject: Re: [PATCH] Bluetooth: Link Keys should be stored if MITM is not
 required
Message-ID: <20120403114129.GA28294@x220.ger.corp.intel.com>
References: <1333444794-27148-1-git-send-email-vishal.agarwal@stericsson.com>
 <20120403093803.GA21118@x220>
 <B4268AAFAFA3E244B5B0641D591491704EA2851205@EXDCVYMBSTM006.EQ1STM.local>
 <20120403102117.GA23054@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120403102117.GA23054@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishal,

On Tue, Apr 03, 2012, Johan Hedberg wrote:
> Hi Vishal,
> 
> On Tue, Apr 03, 2012, Vishal AGARWAL wrote:
> > I am testing with PTS. I have attached the HCI dump also for this
> > case.
> 
> First of all please stop top posting. It's not tolerated on this list.
> Replying to an inline quoted mail makes it even doubly worse since it
> completely messes up the history of the thread.
> 
> About the hcidump you attached we're getting the following from the
> remote device:
> 
>  HCI Event: IO Capability Response (0x32) plen 9
>     bdaddr 00:80:98:E7:32:4C capability 0x01 oob 0x00 auth 0x00
>     Capability: DisplayYesNo (OOB data not present)
>     Authentication: No Bonding (No MITM Protection)
> 
> I.e. the PTS is telling us to *not* store the key. Which test case is
> this? To my understanding the PTS doesn't have BR/EDR GAP tests but you
> need to use the BITE for them. Has something changed in that regard?
> 
> Looking at the full trace we're getting a link key request before
> dropping the ACL. What we should probably do is to not immediately drop
> the key from our list but instead keep it there as long as the
> connection is up. I think that would still be in line with what the
> specification expects us to do with no-bonding keys.
> 
> Now that I look at hciops it's more or less what's happening: it never
> writes the key to the file system but does keep it in its list at
> runtime.
> 
> So to conclude, the right fix is not what you've proposed but to modify
> the code to hang on to the key until the ACL link goes down. I.e. please
> add a "persistent" flag to struct link_key and add code to remove any
> such keys from hdev->link_keys when the ACL goes away.

Additionally, to avoid iterating hdev->link_keys unnecessarily it'd
probably make sense to add a flag to hci_conn to indicate that it has a
temporary key in hdev->link_keys, or maybe even add a direct reference
to the key to struct hci_conn.

Also, please let me know if you can do this by the end of this week
since it's something that should preferably be fixed before 3.4 goes
out.

Johan
