Return-Path: <cyrus@holtmann.org>
Date: Thu, 27 Sep 2012 17:44:24 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, mathewm@codeaurora.org
Subject: Re: [PATCHv7 00/19] Bluetooth: Create AMP physical link
Message-ID: <20120927204424.GA15463@joana>
References: <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1348755984-6403-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348755984-6403-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-09-27 17:26:05 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> This set of patches enhances A2MP protocol and creates physical
> link between AMP controllers. This is further iteration towards
> Bluetooth High Speed.
> 
> Changes:
> 	* p7: Fix ctrl_lookup, add phylink accept functions.
> 	* p6: Refactoring: moving code from pal.[ch] to amp.[ch]
> 	* p5: Fix issues reported by Mat in mailing list review
> 	* p4: Rebased against recent bluetooth-next, minor fixes
> 	* p3: Use hci_conn for representing physical link(type AMP_LINK) instead of
> 	struct phy_link, refactoring.
> 	* p2: Remove HCI callbacks and use amp_mgr global list, refactor code.
> 	* p1: Fixed locking issues, added basic logical link preparation.
> 	* v3: Remove workqueue from callback processing; change callback functions
> 	names according to reviewers recommendations; create global amp_mgr_list to
> 	have lookup to amp manager, physical and logical links so for those HCI events
> 	which might be identified by __handler__ we have lookup; remove extensive
> 	hexdump from gen_amp_key.
> 	* v2: Fix typos and bugs, add functionality: now physical connection
> 	might be established.
> 	* v1: Fix typos, change debug prints, refactor code for better
> 	splitting functionality.
> 
> Andrei Emeltchenko (18):
>   Bluetooth: Add HCI logical link cmds definitions
>   Bluetooth: A2MP: Create amp_mgr global list
>   Bluetooth: AMP: Use HCI cmd to Read AMP Info
>   Bluetooth: AMP: Use HCI cmd to Read Loc AMP Assoc
>   Bluetooth: A2MP: Process Discover Response
>   Bluetooth: AMP: Physical link struct and heplers
>   Bluetooth: AMP: Remote AMP ctrl definitions
>   Bluetooth: AMP: Handle create / disc phylink req
>   Bluetooth: A2MP: Process A2MP Getinfo Rsp
>   Bluetooth: A2MP: Process A2MP Get AMP Assoc Rsp
>   Bluetooth: Choose connection based on capabilities
>   Bluetooth: AMP: Add AMP key calculation
>   Bluetooth: AMP: Create Physical Link
>   Bluetooth: AMP: Write remote AMP Assoc
>   Bluetooth: A2MP: Add fallback to normal l2cap init sequence
>   Bluetooth: AMP: Process Chan Selected event
>   Bluetooth: AMP: Accept Physical Link
>   Bluetooth: AMP: Handle Accept phylink command status evt
> 
> Dmitry Kasatkin (1):
>   Bluetooth: Add function to derive AMP key using hmac

All 19 patches were applied to bluetooth-next. Thanks.

	Gustavo
