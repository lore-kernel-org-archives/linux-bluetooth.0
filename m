Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] non-blocking device discovery
From: Marcel Holtmann <marcel@holtmann.org>
To: Stephen Crane <steve.crane@rococosoft.com>
Cc: Fred =?ISO-8859-1?Q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1073403253.26243.1099.camel@baroque.rococosoft.com>
References: <1073308932.26243.1058.camel@baroque.rococosoft.com>
	 <200401052012.34307.bluez-devel@schaettgen.de>
	 <1073403253.26243.1099.camel@baroque.rococosoft.com>
Content-Type: text/plain
Message-Id: <1073450652.2508.116.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 07 Jan 2004 05:44:13 +0100

Hi Stephen,

> Now onto my new question, what are the semantics of OCF_INQUIRY? I seem
> to be getting one unique device per inquiry call. That is I get one
> EVT_INQUIRY_RESULT event with a bdaddr I haven't seen before and then it
> terminates with an EVT_INQUIRY_COMPLETE. For example:
> 
> inquiry
> found 00:aa:bb:cc:dd:ee
> inquiry complete
> ...
> inquiry
> found 00:aa:bb:cc:dd:ee
> found 00:aa:bb:cc:dd:ef
> inquiry complete
> 
> ...and so on. It seems that when it finds a new device, it passes that
> back up and exits inquiry mode. Can this be right (or have I fscked
> up)?  It only stays in inquiry mode for the specified length of time
> when there are no new devices to be found.

this is not the whole story. What you see is the behaviour of the CSR,
Ericsson and ST based devices, which filter out duplicates. The devices
from Nokia, Broadcom and AVM report every device and it is possible that
you see some bdaddr's more than once.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
