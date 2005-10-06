Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4345A239.5060901@fusion-labs.com>
From: Shawn Fisher <sfisher@fusion-labs.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] Question regarding MS bluetooth keyboard/mouse
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 06 Oct 2005 16:16:25 -0600

Hi, I am unsure as to where to post this, if this is the wrong place, 
please feel free to let me know.  Please don't be irritated if this is 
in the wrong list, I am out of ideas, and this was the last place I had 
left to ask this question.

I recently purchased the MS Keyboard Elite/Intellimouse combo for 
bluetooth, and I do have them running with bluez (Version 2.19) under 
kernel version 2.6.13.2.   While I could care less about getting the 
multimedia keys working on the keyboard, I do have a problem with the 
mouse wheel not working in anything(Including xev). 

I usually just run hidd --search and it brings up both the devices, but 
when I do a(n) hidd --show, it shows both of the devices connected using 
boot-protocol.  My thought (At least from reading about the 
boot-protocol in the kernel documentation) was that this setup was the 
very basic setup for a wireless mouse/keyboard combination, and that 
nothing else besides the 104 key/3 mouse buttons were supported).

I have scoured the web and found lots of somewhat out-dated material 
involving bt-hidd (Which from what I gather has since been incorporated 
into Bluez), changing my xorg.conf script to use ExplorerPS/2, etc, but 
nothing has helped me find a solution to this issue.  Running cat on 
/dev/mouseX from the command line will show activity in the mouse when I 
move, and press one of the 3 common mouse buttons, but nothing shows up 
for the wheel (the 2 side buttons and the tilt buttons are in the same 
category, but of little importance to me).

I should also let you know that I have no problems being a test subject, 
if there are any patches (I did try applying the 2.6.13-MH1) I could 
test out for anyone.  I am also fairly competent with c (I would love to 
wrestle with this problem myself, but have a quite a bit on my plate 
already), and am willing to help out wherever possible.

If there is any more information you may need, feel free to let me know,
Shawn


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
