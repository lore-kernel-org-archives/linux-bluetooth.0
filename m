Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41A3B992.7080202@phaldor.co.uk>
From: Dave Givens <dave.givens@phaldor.co.uk>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth Printing (Belkin Print Server)
References: <41A2089D.5030100@phaldor.co.uk>	 <1101139759.15086.14.camel@pegasus> <41A21EE3.5060408@phaldor.co.uk>	 <20041123091654.GB16952@suse.de> <1101202810.26578.61.camel@pegasus>	 <41A35BFE.9000507@phaldor.co.uk> <1101226220.27351.4.camel@pegasus>	 <41A36388.4010301@phaldor.co.uk> <1101227784.27351.7.camel@pegasus> <41A3715B.6050101@phaldor.co.uk>
In-Reply-To: <41A3715B.6050101@phaldor.co.uk>
Content-Type: multipart/alternative;
 boundary="------------040700090305080105030808"
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 23 Nov 2004 22:28:34 +0000

This is a multi-part message in MIME format.
--------------040700090305080105030808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcel,
    Sorry for the stupid question, here are the results you asked for.

sdptest............
Sequence
    Attribute 0x0000 - Service record handle
        UINT32 0x00010000
    Attribute 0x0001 - Service class ID list
        Sequence
            UUID32 0x00001101
    Attribute 0x0004 - Protocol descriptor list
        Sequence
            Sequence
                UUID32 0x00000100
            Sequence
                UUID32 0x00000003
                UINT8 0x03
    Attribute 0x0100
        String Virtual [USB Printer]
Sequence
    Attribute 0x0000 - Service record handle
        UINT32 0x00010001
    Attribute 0x0001 - Service class ID list
        Sequence
            UUID16 0x1126 - HCR Print
    Attribute 0x0004 - Protocol descriptor list
        Sequence
            Sequence
                UUID16 0x0100 - L2CAP
                UINT16 0x1013
            Sequence
                UUID16 0x0012 - Hardcopy Control Channel
    Attribute 0x000d - Additional protocol descriptor lists
        Sequence
            Sequence
                Sequence
                    UUID16 0x0100 - L2CAP
                    UINT16 0x1011
                Sequence
                    UUID16 0x0014 - Hardcopy Data Channel
    Attribute 0x0100
        String Hardcopy Cable Replacement
    Attribute 0x0300
        String 00 38 4d 46 47 3a 53 74 61 72 3b 43 4d 44 3a 53 54 41 52 
3b 4d 44 4c 3a 54 53 50 37 30 30 20 28 53 54 52 5f 54 2d 55 30 30 31 29 
3b 43 4c 53 3a 50 52 49 4e 54 45 52 3b
    Attribute 0x0302
        String TSP700 (STR_T-U001)
    Attribute 0x0304
        String TSP700 (STR_T-U001)

hcitool .......
Requesting information ...
    BD Address:  00:02:72:40:80:A3
    Device Name: BELKIN_PRT_4080A3
    LMP Version: 1.1 (0x1) LMP Subversion: 0x20d
    Manufacturer: Cambridge Silicon Radio (10)
    Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        <3-slot packets> <5-slot packets> <encryption> <slot offset>
        <timing accuracy> <role switch> <hold mode> <sniff mode>
        <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
        <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
        <power control> <transparent SCO>

Thanks
Dave Givens


Dave Givens wrote:

> Marcel,
>     When I try to run the ./bootstrap command it comes back saying I 
> need configure.ac or configure.in. Which should I use?
>
> Dave Givens
>
> Marcel Holtmann wrote:
>
>>Hi Dave,
>>
>>  
>>
>>>    I am trying to get it to work with a Star TSP700 Thermal printer,
>>>but I have also tried with an HP970CXI and a Canon i865.
>>>    
>>>
>>
>>please checkout the BlueZ libs2 CVS repository and run:
>>
>>	./bootstrap && ./configure && make
>>	./test/sdptest records 00:00:... > file.txt
>>
>>And then send me that file.txt and also the output of "hcitool info".
>>
>>Regards
>>
>>Marcel
>>
>>
>>
>>
>>-------------------------------------------------------
>>SF email is sponsored by - The IT Product Guide
>>Read honest & candid reviews on hundreds of IT Products from real users.
>>Discover which products truly live up to the hype. Start reading now. 
>>http://productguide.itmanagersjournal.com/
>>_______________________________________________
>>Bluez-users mailing list
>>Bluez-users@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/bluez-users
>>
>>
>>  
>>

--------------040700090305080105030808
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body>
Marcel,<br>
&nbsp;&nbsp;&nbsp; Sorry for the stupid question, here are the results you asked for.<br>
<br>
sdptest............<br>
Sequence<br>
&nbsp;&nbsp;&nbsp; Attribute 0x0000 - Service record handle<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; UINT32 0x00010000<br>
&nbsp;&nbsp;&nbsp; Attribute 0x0001 - Service class ID list<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Sequence<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; UUID32 0x00001101<br>
&nbsp;&nbsp;&nbsp; Attribute 0x0004 - Protocol descriptor list<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Sequence<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Sequence<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; UUID32 0x00000100<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Sequence<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; UUID32 0x00000003<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; UINT8 0x03<br>
&nbsp;&nbsp;&nbsp; Attribute 0x0100<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; String Virtual [USB Printer]<br>
Sequence<br>
&nbsp;&nbsp;&nbsp; Attribute 0x0000 - Service record handle<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; UINT32 0x00010001<br>
&nbsp;&nbsp;&nbsp; Attribute 0x0001 - Service class ID list<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Sequence<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; UUID16 0x1126 - HCR Print<br>
&nbsp;&nbsp;&nbsp; Attribute 0x0004 - Protocol descriptor list<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Sequence<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Sequence<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; UUID16 0x0100 - L2CAP<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; UINT16 0x1013<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Sequence<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; UUID16 0x0012 - Hardcopy Control Channel<br>
&nbsp;&nbsp;&nbsp; Attribute 0x000d - Additional protocol descriptor lists<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Sequence<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Sequence<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Sequence<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; UUID16 0x0100 - L2CAP<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; UINT16 0x1011<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Sequence<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; UUID16 0x0014 - Hardcopy Data Channel<br>
&nbsp;&nbsp;&nbsp; Attribute 0x0100<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; String Hardcopy Cable Replacement<br>
&nbsp;&nbsp;&nbsp; Attribute 0x0300<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; String 00 38 4d 46 47 3a 53 74 61 72 3b 43 4d 44 3a 53 54 41 52
3b 4d 44 4c 3a 54 53 50 37 30 30 20 28 53 54 52 5f 54 2d 55 30 30 31 29
3b 43 4c 53 3a 50 52 49 4e 54 45 52 3b<br>
&nbsp;&nbsp;&nbsp; Attribute 0x0302<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; String TSP700 (STR_T-U001)<br>
&nbsp;&nbsp;&nbsp; Attribute 0x0304<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; String TSP700 (STR_T-U001)<br>
<br>
hcitool .......<br>
Requesting information ...<br>
&nbsp;&nbsp;&nbsp; BD Address:&nbsp; 00:02:72:40:80:A3<br>
&nbsp;&nbsp;&nbsp; Device Name: BELKIN_PRT_4080A3<br>
&nbsp;&nbsp;&nbsp; LMP Version: 1.1 (0x1) LMP Subversion: 0x20d<br>
&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon Radio (10)<br>
&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &lt;3-slot packets&gt; &lt;5-slot packets&gt;
&lt;encryption&gt; &lt;slot offset&gt; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &lt;timing accuracy&gt; &lt;role switch&gt; &lt;hold mode&gt;
&lt;sniff mode&gt; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &lt;park state&gt; &lt;RSSI&gt; &lt;channel quality&gt; &lt;SCO
link&gt; &lt;HV2 packets&gt; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law log&gt;
&lt;CVSD&gt; &lt;paging scheme&gt; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &lt;power control&gt; &lt;transparent SCO&gt; <br>
<br>
Thanks<br>
Dave Givens<br>
<br>
<br>
Dave Givens wrote:<br>
<blockquote type="cite" cite="mid41A3715B.6050101@phaldor.co.uk">
  <meta content="text/html;" http-equiv="Content-Type">
  <title></title>
Marcel,<br>
&nbsp;&nbsp;&nbsp; When I try to run the ./bootstrap command it comes back saying I
need configure.ac or configure.in. Which should I use?<br>
  <br>
Dave Givens<br>
  <br>
Marcel Holtmann wrote:<br>
  <blockquote cite="mid1101227784.27351.7.camel@pegasus" type="cite">
    <pre wrap="">Hi Dave,

  </pre>
    <blockquote type="cite">
      <pre wrap="">    I am trying to get it to work with a Star TSP700 Thermal printer,
but I have also tried with an HP970CXI and a Canon i865.
    </pre>
    </blockquote>
    <pre wrap=""><!---->
please checkout the BlueZ libs2 CVS repository and run:

	./bootstrap &amp;&amp; ./configure &amp;&amp; make
	./test/sdptest records 00:00:... &gt; file.txt

And then send me that file.txt and also the output of "hcitool info".

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest &amp; candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
<a href="http://productguide.itmanagersjournal.com/"
 class="moz-txt-link-freetext">http://productguide.itmanagersjournal.com/</a>
_______________________________________________
Bluez-users mailing list
<a href="mailto:Bluez-users@lists.sourceforge.net"
 class="moz-txt-link-abbreviated">Bluez-users@lists.sourceforge.net</a>
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-users"
 class="moz-txt-link-freetext">https://lists.sourceforge.net/lists/listinfo/bluez-users</a>


  </pre>
  </blockquote>
</blockquote>
</body>
</html>

--------------040700090305080105030808--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
