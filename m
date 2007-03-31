Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <c49421c50703311344m137d7fddm1b43fb78dd3481@mail.gmail.com>
Date: Sat, 31 Mar 2007 17:44:36 -0300
From: "Loreno Oliveira" <lorenooliveira@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY124-W139C835870F41AFA3D794AF0620@phx.gbl>
MIME-Version: 1.0
References: <BAY124-W139C835870F41AFA3D794AF0620@phx.gbl>
Subject: Re: [Bluez-users] Multithread Service Discovery
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1436006930=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1436006930==
Content-Type: multipart/alternative;
	boundary="----=_Part_90823_1446838.1175373876046"

------=_Part_90823_1446838.1175373876046
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Robert,

don't know if I understood your needs. Let me check. You have a client
device A that needs to inquiy neraby devices and check which of them have a
certain service of interest of A. once found such devices, A will connect to
each and consume the service. Is that right?

If this is your situation, I dealt with the same scenario some days ago in
the project I am developing. In my case, to avoid connect and query all the
devices foind during inquiry about the presence of a certain service, I
changed the device class of the devices that have the service I need. So, my
discovering phase now is quite efficient, because along with the information
of remote devices, gotten after inquiry, that are the bits that describe the
class of the remote device. So I can now discard all the devices that do not
have the bit that describe availability of a service I need.

Well, this is just my experience. In me scenario this solution is feasible
because the requeriments of my project allow it. Maybe it can be applied to
your project, maybe not :-)

Cheers!

Loreno

On 3/31/07, Robert Rawlins <robert_rawlins@hotmail.com> wrote:
>
> Hello Guys,
>
> Thank you both for your replies, this is interesting stuff.
>
> I spent some time this afternoon playing around with multithreading an SDP
> enquiry, whilst i've almost got it working, when i use the loop to initiate
> the threads they all seem to get their arguments mixed up, so when i loop
> through the join i get the wrong details returned, they all list the same
> mac address but with different channels, unfortunately i'm away from my code
> at the moment so cant post any samples.
>
> Basically i'm trying to do a device discovery, and then SDP each of the
> devices to obtain the obex channel, which i can then use to push a file to,
> and i'm looking to have it do this as quickly as possible.
>
> What would you recommend the best method for something like this? At the
> moment i'm using a C program, a large amount of the code from it is stripped
> out of an excellent article written by Albert Huang found here
> http://people.csail.mit.edu/albert/bluez-intro/c401.html.
>
> I note that a lot of people recently have been talking about the D-Bus
> API, is this something i should perhaps be using? does it suite my
> requirements?
>
> I've looked through the API documentation and it appears to have some
> excellent functions, however as novice C programmer, I'm a little bit lost
> as to where i might start with integrating the API into my application.
>
> Thanks again for any help guys,
>
> Rob
>
> ------------------------------
> With Live Spaces email straight to your blog. Upload jokes, photos and
> more. It's free! It's free!<http://specials.uk.msn.com/spaces/default.aspx+>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>

------=_Part_90823_1446838.1175373876046
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Robert,<br><br>don&#39;t know if I understood your needs. Let me check. You have a client device A that needs to inquiy neraby devices and check which of them have a certain service of interest of A. once found such devices, A will connect to each and consume the service. Is that right?
<br><br>If this is your situation, I dealt with the same scenario some days ago in the project I am developing. In my case, to avoid connect and query all the devices foind during inquiry about the presence of a certain service, I changed the device class of the devices that have the service I need. So, my discovering phase now is quite efficient, because along with the information of remote devices, gotten after inquiry, that are the bits that describe the class of the remote device. So I can now discard all the devices that do not have the bit that describe availability of a service I need.
<br><br>Well, this is just my experience. In me scenario this solution is feasible because the requeriments of my project allow it. Maybe it can be applied to your project, maybe not :-)<br><br>Cheers!<br><br>Loreno<br><br>
<div><span class="gmail_quote">On 3/31/07, <b class="gmail_sendername">Robert Rawlins</b> &lt;<a href="mailto:robert_rawlins@hotmail.com">robert_rawlins@hotmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">




<div>Hello Guys,<br>
&nbsp;<br>
Thank you both for your replies, this is interesting stuff.<br>
&nbsp;<br>
I spent some time this afternoon playing around with multithreading an SDP enquiry, whilst i&#39;ve almost got it working, when i use the loop to initiate the threads they all seem to get their arguments mixed up, so when i loop through the join i get the wrong details returned, they all list the same mac address but with different channels, unfortunately i&#39;m away from my code at the moment so cant post any samples.
<br>
&nbsp;<br>
Basically i&#39;m trying to do a device discovery, and then SDP each of the devices to obtain the obex channel, which i can then use to push a file to, and i&#39;m looking to have it&nbsp;do this as quickly as possible.<br>
&nbsp;<br>
What would you recommend the best method for something like this? At the moment i&#39;m using a C program, a large amount of the code from it is stripped out of an excellent article written by Albert Huang found here <a href="http://people.csail.mit.edu/albert/bluez-intro/c401.html" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
http://people.csail.mit.edu/albert/bluez-intro/c401.html</a>.<br>
&nbsp;<br>
I note that a lot of people recently have been talking about the D-Bus API, is this something i should perhaps be using? does it suite my requirements?<br>
&nbsp;<br>
I&#39;ve looked through the API documentation and it appears to have some excellent functions, however as novice C programmer, I&#39;m a little bit lost as to where i might start with integrating the API into my application.
<br>
&nbsp;<br>
Thanks again for any help guys,<span class="q"><br>
&nbsp;<br>
Rob<br><br><hr>With Live Spaces email straight to your blog. Upload jokes, photos and more. It&#39;s free! <a href="http://specials.uk.msn.com/spaces/default.aspx+" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
It&#39;s free!</a></span></div>
<br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your
<br>opinions on IT &amp; business topics through brief surveys-and earn cash<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV" target="_blank">
http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>_______________________________________________<br>Bluez-users mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Bluez-users@lists.sourceforge.net">
Bluez-users@lists.sourceforge.net</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users
</a><br><br></blockquote></div><br>

------=_Part_90823_1446838.1175373876046--


--===============1436006930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1436006930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1436006930==--
