Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluetooth kernel patch for 2.6.0
From: Edd Dumbill <edd@usefulinc.com>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1073041104.25261.15.camel@pegasus>
References: <1073041104.25261.15.camel@pegasus>
Content-Type: text/plain
Message-Id: <1073084609.8731.4.camel@saag>
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
Date: Fri, 02 Jan 2004 23:03:29 +0000

On Fri, 2004-01-02 at 10:58, Marcel Holtmann wrote:
> Hi Folks,
> 
> the second Bluetooth kernel patch for 2.6.0 is now available 

I find that with this patch and the latest utils/libs that hcitool
behaves oddly right after a reboot.  hcitool scan or inq return straight
away without any results.

If I fiddle around a bit with other programs that create bluetooth
connections I find that hcitool works as expected again.

-- Edd




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
