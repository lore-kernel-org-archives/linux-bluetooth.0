Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Michael Wever <mick@machina.no>
Message-ID: <pan.2004.03.29.10.58.33.731525@machina.no>
References: <pan.2004.03.29.08.17.54.697624@netbeans.org> <1080556737.2281.217.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [Bluez-users] Re: Bluetooth device missing after kernel recompile
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 29 Mar 2004 12:58:40 +0200

On Mon, 29 Mar 2004 12:38:57 +0200, Marcel Holtmann wrote:
>> "Device is not available.: Success".
> 
> this means that your device is not detected. Does it show up in lsmod?
> What kernel do you have changed? What do lspci say?
> 

Output from lsmod was in original post,
lspci | grep USB

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01)
00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 01)



>> What am I missing? 
> 
> Come on, do you ever created the eth0 device under /dev? This is
> networking, so no device nodes are needed.

Sure :$ inserting the right module is required.
So my question should be what is the module that I need for "Intel Corp. 82801DB USB"?

Mick.

-- 
-- <BR/>
"Great spirits have always encountered violent opposition from mediocre minds." Albert Einstein
<BR/> --- <a href=http://www.harryspractice.com.au>Harry's Practice</a> --- 




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
