Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4346BC18.4080601@fusion-labs.com>
From: Shawn Fisher <sfisher@fusion-labs.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Question regarding MS bluetooth keyboard/mouse
References: <4345A239.5060901@fusion-labs.com> <1128669192.8750.3.camel@localhost.localdomain>
In-Reply-To: <1128669192.8750.3.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Fri, 07 Oct 2005 12:19:04 -0600

Boy, I am very embarrassed, it appears that when I did apply the patch, 
I was also patching some swsusp2 stuff and testing that out.  Anyways, 
it looks like the process I used to get bluetooth working may have 
involved swapping the patched sources with an unpatched kernel(Sigh).  I 
retested it with the patch, and the mouse wheel works flawlessly.  Sorry 
to have wasted your time.

Shawn

Marcel Holtmann wrote:

>Hi Shawn,
>
>  
>
>>I am unsure as to where to post this, if this is the wrong place, 
>>please feel free to let me know.  Please don't be irritated if this is 
>>in the wrong list, I am out of ideas, and this was the last place I had 
>>left to ask this question.
>>
>><snip>
>>I should also let you know that I have no problems being a test subject, 
>>if there are any patches (I did try applying the 2.6.13-MH1) I could 
>>test out for anyone.  I am also fairly competent with c (I would love to 
>>wrestle with this problem myself, but have a quite a bit on my plate 
>>already), and am willing to help out wherever possible.
>>    
>>
>
>using patch-2.6.13-mh1 gives report mode protocol support, but this
>doesn't mean all Microsoft specific stuff is supported. I only have the
>old Microsoft Bluetooth desktop at home and the mouse works perfect with
>this patch. Maybe they changed some reports for their new model.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by:
>Power Architecture Resource Center: Free content, downloads, discussions,
>and more. http://solutions.newsforge.com/ibmarch.tmpl
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>  
>



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
