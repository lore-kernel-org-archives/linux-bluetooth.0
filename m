Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: "Aveek Audhya" <aveek@rebaca.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Fri, 1 Jun 2007 19:18:02 +0530
MIME-Version: 1.0
In-Reply-To: <1180624077.3030.184.camel@cookie.hadess.net>
Message-ID: <E1Hu7Ub-0003BE-La@mail.sourceforge.net>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-devel] connect fail : Operation now in progress
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0213695949=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0213695949==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0000_01C7A481.956BE0C0"

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C7A481.956BE0C0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Nocera,
      Thanks for your reply. What I have seen is that my socket's fd is by
default blocking, every time it returns -1 after waiting for sometime. If I
set it as non-blocking then it returns -1 immediately.  
      I have set up a watcher with select() and getsockopt() call. 
It's like that ....
 
s = socket(AF_BLUETOOTH, SOCK_STREAM/*SOCK_SEQPACKET*/, BTPROTO_RFCOMM);
 
remote_addr.rc_family = AF_BLUETOOTH; // specifies the addressing family of
the socket
remote_addr.rc_channel = (uint8_t)4; // port no to connect to
str2ba(dest, &remote_addr.rc_bdaddr); // address to connect to
 
status = connect(s, (struct sockaddr*)&remote_addr, sizeof(struct
sockaddr_rc));
 
if(status < 0)
      {
            if(errno == EINPROGRESS)
            {
                  printf("EINPROGRESS : %s\n",strerror(errno));
                  do
                  {
                        timeout.tv_sec = 25;
                        timeout.tv_usec = 0;
                        FD_ZERO(&wr);
                        FD_ZERO(&rd);     
                        FD_ZERO(&exceptfds);
 
                        FD_SET(s,&wr);
                        FD_SET(s,&rd);
                        FD_SET(s,&exceptfds);
 
                        if((status =
select(s+1,&rd,&wr,&exceptfds,&timeout)) >0 )
                        {
                              //struct protoent *result;
                              len = sizeof(int);
                              //while((result = getprotoent()) != NULL)
                              //printf("name = %s, protocol =
%d\n",result->p_name,result->p_proto); 
 
                              
                  if(getsockopt(s,SOL_RFCOMM,SO_ERROR,(void*)&valopt,&len) <
0)
                              {
                                    printf("Error in getsockopt() %d -
%s\n",errno,strerror(errno));
                                    _exit(0);
                              }
                        
                              if(valopt) // check the value returned
                              {     
                                    printf("Error in delayed connection() %d
- %s\n",valopt,strerror(valopt));
                                    _exit(0);
                              }
                              printf("before break\n");
                              break;
                        }
                        else if(status < 0 && errno != EINTR)
                        {
                              printf("Error connecting %d - %s\n",errno,
strerror(errno));
                              _exit(0);
                        }
                        else
                        {
                              printf("errno = %d\n",errno);
                              perror("Timeout in select(). exiting... ");
                              _exit(0);
                        }
                  }while(1); /**/
            }
            else
            {
                  printf("errno = %d\n",errno);
                  perror("Error in connect. exiting... ");
                  _exit(0);
            }
      }
 
But for SOL_RFCOMM in getsockopt() I get an error message at run time ..
Error in getsockopt() 92 - Protocol not available ..... although SOL_RFCOMM
is defined in '/usr/include/Bluetooth/bluetooth.h'. Is it the right way to
implement a watcher on a socket fd ? 
 
One thing I forgot to mention that after making connect() call, my mobile
phone ask for 'accept connection request', and after pressing 'yes'
connect() returns -1 with error value 'Operation now in progress'.    
 
Unfortunately I couldn't find 'manager.c' in 'bluez-utils-3.9/serial/'. The
folder doesn't contain any .c file except Makefile, Makefile.am and
Makefile.in. 'manager.c' is present only in 'bluez-utils-3.9/daemon' folder,
but there is no 'rfcomm_connect()' implementation. Probably we are using
different utils version.
Thanks again for your time.
 
 
-----Original Message-----
From: Bastien Nocera [mailto:hadess@hadess.net] 
Sent: Thursday, May 31, 2007 8:38 PM
To: BlueZ development
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-devel] connect fail : Operation now in progress
 
On Thu, 2007-05-31 at 16:44 +0530, Aveek Audhya wrote:
> Hi,
> 
>             I am trying to communicate with a J2ME application running
> on my mobile phone(Nokia 6600) using a client program running on a
> Linux machine (FC6). The 'sdptool browse' reports that the J2ME
> application is listening on channel 4. The J2ME application is using
> btspp protocol whereas my client side application is using RFCOMM. But
> when I run the client application, the 'connect' system-call fails
> (returns -1) with error value "Operation now in progress". I am using
> BlueZ protocol stack.
> 
> What can be the probable reason for this kind of behavior? Any
> suggestion is appreciated.
 
You probably made the socket's fd non-blocking. Either make it blocking,
or setup a watcher on the fd to wait for the link to be created.
 
See rfcomm_connect() in bluez-utils/serial/manager.c
 
-- 
Bastien Nocera <hadess@hadess.net> 
 
 
-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_NextPart_000_0000_01C7A481.956BE0C0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 11">
<meta name=3DOriginator content=3D"Microsoft Word 11">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C7A481.92C21D80">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PersonName"/>
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:UseWord2002TableStyleRules/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState=3D"false" LatentStyleCount=3D"156">
 </w:LatentStyles>
</xml><![endif]--><!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Courier New";
	mso-fareast-font-family:"Times New Roman";}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 77.95pt 1.0in 77.95pt;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";
	mso-ansi-language:#0400;
	mso-fareast-language:#0400;
	mso-bidi-language:#0400;}
</style>
<![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:.5in'>

<div class=3DSection1>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Hi <span =
class=3DSpellE>Nocera</span>,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>Thanks
for your reply. What I have seen is that my socket's <span =
class=3DSpellE><span
class=3DGramE>fd</span></span> is by default blocking, every time it =
returns -1
after waiting for sometime. If I set it as non-blocking then it returns =
-1
immediately. <span =
style=3D'mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><span style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>I have
set up a watcher with <span class=3DGramE>select(</span>) and <span =
class=3DSpellE>getsockopt</span>()
call. <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>It's like <span class=3DGramE>that =
....</span><o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'>s =3D <span =
class=3DGramE>socket(</span>AF_BLUETOOTH,
SOCK_STREAM/*SOCK_SEQPACKET*/, =
BTPROTO_RFCOMM);<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoPlainText><span class=3DSpellE><font size=3D2 color=3Dblue
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:blue'>remote_addr.rc_family</span></font>=
</span><font
color=3Dblue><span style=3D'color:blue'> =3D AF_BLUETOOTH; // specifies =
the
addressing family of the socket<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><span class=3DSpellE><font size=3D2 color=3Dblue
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:blue'>remote_addr.rc_channel</span></font=
></span><font
color=3Dblue><span style=3D'color:blue'> =3D (uint8_t<span =
class=3DGramE>)4</span>; //
port no to connect to<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><span class=3DGramE><font size=3D2 color=3Dblue
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:blue'>str2ba(</span></font></span><span
class=3DSpellE><font color=3Dblue><span =
style=3D'color:blue'>dest</span></font></span><font
color=3Dblue><span style=3D'color:blue'>, &amp;<span =
class=3DSpellE>remote_addr.rc_bdaddr</span>);
// address to connect to<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoPlainText><span class=3DGramE><font size=3D2 color=3Dblue
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:blue'>status</span></font></span><font
color=3Dblue><span style=3D'color:blue'> =3D connect(s, (<span =
class=3DSpellE>struct</span>
<span class=3DSpellE>sockaddr</span>*)&amp;<span =
class=3DSpellE>remote_addr</span>,
<span class=3DSpellE>sizeof</span>(<span class=3DSpellE>struct</span> =
<span
class=3DSpellE>sockaddr_rc</span>));<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoPlainText><span class=3DGramE><font size=3D2 color=3Dblue
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:blue'>if(</span></font></span><font
color=3Dblue><span style=3D'color:blue'>status &lt; =
0)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>{<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; </span><span
class=3DGramE>if(</span><span class=3DSpellE>errno</span> =3D=3D =
EINPROGRESS)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; </span>{<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:3'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
class=3DSpellE><span class=3DGramE>printf</span></span><span =
class=3DGramE>(</span>&quot;EINPROGRESS
: %s\<span class=3DSpellE>n&quot;,strerror</span>(<span =
class=3DSpellE>errno</span>));<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:3'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
class=3DGramE>do</span><o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:3'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>{<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:4'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; </span><span
class=3DSpellE>timeout.tv_sec</span> =3D =
25;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:4'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; </span><span
class=3DSpellE>timeout.tv_usec</span> =3D =
0;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:4'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; </span>FD_<span
class=3DGramE>ZERO(</span>&amp;<span =
class=3DSpellE>wr</span>);<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:4'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; </span>FD_<span
class=3DGramE>ZERO(</span>&amp;rd);<span =
style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp; =
</span><o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:4'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; </span>FD_<span
class=3DGramE>ZERO(</span>&amp;<span =
class=3DSpellE>exceptfds</span>);<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:4'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; </span>FD_SET(<span
class=3DSpellE>s<span =
class=3DGramE>,&amp;</span>wr</span>);<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:4'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; </span>FD_SET(<span
class=3DSpellE>s<span =
class=3DGramE>,&amp;</span>rd</span>);<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:4'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; </span>FD_SET(<span
class=3DSpellE>s<span =
class=3DGramE>,&amp;</span>exceptfds</span>);<o:p></o:p></span></font></p=
>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:4'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; </span><span
class=3DGramE>if(</span>(status =3D
select(s+1,&amp;rd,&amp;wr,&amp;exceptfds,&amp;timeout)) &gt;0 =
)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:4'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; </span>{<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:5'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>//<span
class=3DSpellE>struct</span> <span class=3DSpellE>protoent</span> =
*result;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:5'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
class=3DSpellE><span class=3DGramE>len</span></span> =3D <span =
class=3DSpellE>sizeof</span>(<span
class=3DSpellE>int</span>);<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:5'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>//<span
class=3DGramE>while(</span>(result =3D <span =
class=3DSpellE>getprotoent</span>()) !=3D
NULL)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:5'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>//<span
class=3DSpellE><span class=3DGramE>printf</span></span><span =
class=3DGramE>(</span>&quot;name
=3D %s, protocol =3D %d\<span =
class=3DSpellE>n&quot;,result</span>-&gt;<span
class=3DSpellE>p_name,result</span>-&gt;<span =
class=3DSpellE>p_proto</span>); <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:5'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span><o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:3'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
class=3DGramE>if(</span><span class=3DSpellE>getsockopt</span>(<span =
class=3DSpellE>s,SOL_RFCOMM,SO_ERROR</span>,(void*)&amp;<span
class=3DSpellE>valopt,&amp;len</span>) &lt; =
0)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:5'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>{<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:6'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; </span><span
class=3DSpellE><span class=3DGramE>printf</span></span><span =
class=3DGramE>(</span>&quot;Error
in <span class=3DSpellE>getsockopt</span>() %d - %s\<span =
class=3DSpellE>n&quot;,errno,strerror</span>(<span
class=3DSpellE>errno</span>));<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:6'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; </span>_<span
class=3DGramE>exit(</span>0);<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:5'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>}<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:4'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; </span><o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:5'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
class=3DGramE>if(</span><span class=3DSpellE>valopt</span>) // check the =
value
returned<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:5'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>{<span
style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp; =
</span><o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:6'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; </span><span
class=3DSpellE><span class=3DGramE>printf</span></span><span =
class=3DGramE>(</span>&quot;Error
in delayed connection() %d - %s\<span =
class=3DSpellE>n&quot;,valopt,strerror</span>(<span
class=3DSpellE>valopt</span>));<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:6'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; </span>_<span
class=3DGramE>exit(</span>0);<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:5'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>}<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:5'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
class=3DSpellE><span class=3DGramE>printf</span></span><span =
class=3DGramE>(</span>&quot;before
break\n&quot;);<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:5'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
class=3DGramE>break</span>;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:4'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; </span>}<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:4'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; </span><span
class=3DGramE>else</span> if(status &lt; 0 &amp;&amp; <span =
class=3DSpellE>errno</span>
!=3D EINTR)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:4'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; </span>{<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:5'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
class=3DSpellE><span class=3DGramE>printf</span></span><span =
class=3DGramE>(</span>&quot;Error
connecting %d - %s\<span class=3DSpellE>n&quot;,errno</span>, <span =
class=3DSpellE>strerror</span>(<span
class=3DSpellE>errno</span>));<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:5'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>_<span
class=3DGramE>exit(</span>0);<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:4'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; </span>}<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:4'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; </span><span
class=3DGramE>else</span><o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:4'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; </span>{<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:5'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
class=3DSpellE><span class=3DGramE>printf</span></span><span =
class=3DGramE>(</span>&quot;<span
class=3DSpellE>errno</span> =3D %d\<span =
class=3DSpellE>n&quot;,errno</span>);<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:5'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
class=3DSpellE><span class=3DGramE>perror</span></span><span =
class=3DGramE>(</span>&quot;Timeout
in select(). <span class=3DGramE>exiting</span>... =
&quot;);<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:5'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>_<span
class=3DGramE>exit(</span>0);<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:4'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; </span>}<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:3'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
class=3DGramE>}while</span>(1); /**/<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; </span>}<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; </span><span
class=3DGramE>else</span><o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; </span>{<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:3'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
class=3DSpellE><span class=3DGramE>printf</span></span><span =
class=3DGramE>(</span>&quot;<span
class=3DSpellE>errno</span> =3D %d\<span =
class=3DSpellE>n&quot;,errno</span>);<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:3'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
class=3DSpellE><span class=3DGramE>perror</span></span><span =
class=3DGramE>(</span>&quot;Error
in connect. <span class=3DGramE>exiting</span>... =
&quot;);<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:3'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>_<span
class=3DGramE>exit(</span>0);<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; </span>}<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblue face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:blue'><span =
style=3D'mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>}<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>But for <font color=3Dblue><span style=3D'color:blue'>SOL_RFCOMM =
</span></font>in
<span class=3DSpellE><span class=3DGramE>getsockopt</span></span><span =
class=3DGramE>(</span>)
I get an error message at run time &#8230;&#8230;<span
style=3D'mso-spacerun:yes'>&nbsp; </span>Error in <span =
class=3DSpellE><span
class=3DGramE>getsockopt</span></span><span class=3DGramE>(</span>) 92 =
&#8211;
Protocol not available &#8230;&#8230;&#8230;&#8230;&#8230; although =
<font
color=3Dblue><span style=3D'color:blue'>SOL_RFCOMM </span></font>is =
defined in &#8216;/<span
class=3DSpellE>usr/include/Bluetooth/bluetooth.h</span>&#8217;. Is it =
the right
way to implement a watcher on a socket <span class=3DSpellE><span =
class=3DGramE>fd</span></span><span
class=3DGramE> ?</span> <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>One thing I forgot to mention that after making <span =
class=3DGramE>connect(</span>)
call, my mobile phone ask for &#8216;accept connection request&#8217;, =
and
after pressing &#8216;yes&#8217; connect() returns -1 with error value =
&#8216;Operation
now in progress&#8217;. <span =
style=3D'mso-spacerun:yes'>&nbsp;</span><span
style=3D'mso-spacerun:yes'>&nbsp;</span><span
style=3D'mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Unfortunately I couldn&#8217;t find &#8216;<span =
class=3DSpellE>manager.c</span>&#8217;
in &#8216;bluez-utils-3.9/serial/&#8217;. The folder doesn&#8217;t =
contain any
.c file except <span class=3DSpellE>Makefile</span>, <span =
class=3DSpellE>Makefile.am</span>
and <span class=3DSpellE>Makefile.in</span>. &#8216;<span =
class=3DSpellE>manager.c</span>&#8217;
is present only in &#8216;bluez-utils-3.9/daemon&#8217; folder, but =
there is no
&#8216;<span class=3DSpellE>rfcomm_<span =
class=3DGramE>connect</span></span><span
class=3DGramE>(</span>)&#8217; implementation. Probably we are using =
different <span
class=3DSpellE>utils</span> version.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Thanks again for your time.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><span =
style=3D'mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>-----Original Message-----<br>
From: Bastien Nocera [mailto:hadess@hadess.net<span class=3DGramE>] <br>
Sent</span>: Thursday, May 31, 2007 8:38 PM<br>
To: BlueZ development<br>
Cc: <st1:PersonName =
w:st=3D"on">bluez-users@lists.sourceforge.net</st1:PersonName><br>
Subject: Re: [Bluez-devel] connect <span class=3DGramE>fail :</span> =
Operation
now in progress</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>On Thu, 2007-05-31 at 16:44 +0530, Aveek Audhya =
wrote:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; Hi,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;
</span>I am trying to communicate with a J2ME application =
running<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; on my mobile phone(Nokia 6600) using a client program =
running on a<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; Linux machine (FC6). The &#8216;sdptool browse&#8217; =
reports that
the J2ME<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; application is listening on channel 4. The J2ME application =
is
using<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; btspp protocol whereas my client side application is using =
RFCOMM.
But<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; when I run the client application, the =
&#8216;connect&#8217;
system-call fails<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; (returns -1) with error value &#8220;Operation now in
progress&#8221;. I am using<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; BlueZ protocol stack.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; What can be the probable reason for this kind of behavior? =
Any<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; suggestion is appreciated.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>You probably made the socket's fd non-blocking. Either make it
blocking,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>or setup a watcher on the fd to wait for the link to be =
created.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>See rfcomm_connect() in =
bluez-utils/serial/manager.c<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>-- <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Bastien Nocera &lt;hadess@hadess.net&gt; =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>-----------------------------------------------------------------=
--------<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>This SF.net email is sponsored by DB2 =
Express<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Download DB2 Express C - the FREE version of DB2 express and =
take<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>control of your XML. No limits. Just data. Click to get it =
now.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>http://sourceforge.net/powerbar/db2/<o:p></o:p></span></font></p>=


<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>_______________________________________________<o:p></o:p></span>=
</font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Bluez-devel mailing list<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><st1:PersonName w:st=3D"on"><font size=3D2 =
face=3D"Courier New"><span
 =
style=3D'font-size:10.0pt'>Bluez-devel@lists.sourceforge.net</span></font=
></st1:PersonName><o:p></o:p></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>https://lists.sourceforge.net/lists/listinfo/bluez-devel<o:p></o:=
p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0000_01C7A481.956BE0C0--




--===============0213695949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0213695949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0213695949==--
