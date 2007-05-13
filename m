Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46475927.2080609@nnytech.net>
Date: Sun, 13 May 2007 14:29:59 -0400
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <432beae0705121846x7b181d3fm180205dfa783e975@mail.gmail.com><432beae0705121900q237f835ahf6d2ac63c619415@mail.gmail.com>	<CE5216C10C83944D9FD37B65CD33F3970CF4D7@mplex01.mpl.access-company.com>	<CE5216C10C83944D9FD37B65CD33F3970CF4D8@mplex01.mpl.access-company.com>
	<46474B6A.1040705@gentoo.org>
In-Reply-To: <46474B6A.1040705@gentoo.org>
From: Feig <e.john.feig@gmail.com>
Subject: Re: [Bluez-devel] RE : RE : Problems connecting to a bluetooth
 headset faoMarcel
Reply-To: e.john.feig@gmail.com,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0199467755=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============0199467755==
Content-Type: multipart/alternative;
	boundary="------------020202050608020706070909"

This is a multi-part message in MIME format.
--------------020202050608020706070909
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Petteri Räty wrote:
> Frederic Dalleau kirjoitti:
>   
>>>> A2DPD[18:44:14.790]: a2dp_make_listen_socket: (errno=13:Permission
>>>> denied)Cannot bind socket 6 for psm 25
>>>>         
>>> I'm wondering what causes this, the bind call is failing with errno=EPERM.
>>> Do you know of something in bluez config or something security related
>>>       
>> that could prevent binding if not root?
>>
>> I should have RTFM
>> http://people.csail.mit.edu/albert/bluez-intro/x145.html#port-numbers
>> Thanks,
>> Frederic
>>
>>
>>     
>
> from http://bluetooth-alsa.sourceforge.net/build.html
> "... and run a2dpd (it's not advised to run it as root)."
>
> Hehe. I wonder what the developers do then as it doesn't work as a
> normal user.
>
> Regards,
> Petteri
>   
I got it to work as a normal user, I don't remember exactly what I did, 
but I'm pretty sure that all it needed was a 'chmod a+x' on the required 
files.

I do think that this could be handled better with an /etc/init.d/ script 
that ran a2dpd as the user. Or even hook it into the 
/etc/init.d/bluetooth script.

-John

--------------020202050608020706070909
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Petteri Räty wrote:
<blockquote cite="mid:46474B6A.1040705@gentoo.org" type="cite">
  <pre wrap="">Frederic Dalleau kirjoitti:
  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <blockquote type="cite">
        <pre wrap="">A2DPD[18:44:14.790]: a2dp_make_listen_socket: (errno=13:Permission
denied)Cannot bind socket 6 for psm 25
        </pre>
      </blockquote>
    </blockquote>
    <blockquote type="cite">
      <pre wrap="">I'm wondering what causes this, the bind call is failing with errno=EPERM.
Do you know of something in bluez config or something security related
      </pre>
    </blockquote>
    <pre wrap="">that could prevent binding if not root?

I should have RTFM
<a class="moz-txt-link-freetext" href="http://people.csail.mit.edu/albert/bluez-intro/x145.html#port-numbers">http://people.csail.mit.edu/albert/bluez-intro/x145.html#port-numbers</a>
Thanks,
Frederic


    </pre>
  </blockquote>
  <pre wrap=""><!---->
from <a class="moz-txt-link-freetext" href="http://bluetooth-alsa.sourceforge.net/build.html">http://bluetooth-alsa.sourceforge.net/build.html</a>
"... and run a2dpd (it's not advised to run it as root)."

Hehe. I wonder what the developers do then as it doesn't work as a
normal user.

Regards,
Petteri
  </pre>
</blockquote>
I got it to work as a normal user, I don't remember exactly what I did,
but I'm pretty sure that all it needed was a 'chmod a+x' on the
required files.<br>
<br>
I do think that this could be handled better with an /etc/init.d/
script that ran a2dpd as the user. Or even hook it into the
/etc/init.d/bluetooth script.<br>
<br>
-John<br>
</body>
</html>

--------------020202050608020706070909--


--===============0199467755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0199467755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0199467755==--
