Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41A3715B.6050101@phaldor.co.uk>
From: Dave Givens <dave.givens@phaldor.co.uk>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth Printing (Belkin Print Server)
References: <41A2089D.5030100@phaldor.co.uk>	 <1101139759.15086.14.camel@pegasus> <41A21EE3.5060408@phaldor.co.uk>	 <20041123091654.GB16952@suse.de> <1101202810.26578.61.camel@pegasus>	 <41A35BFE.9000507@phaldor.co.uk> <1101226220.27351.4.camel@pegasus>	 <41A36388.4010301@phaldor.co.uk> <1101227784.27351.7.camel@pegasus>
In-Reply-To: <1101227784.27351.7.camel@pegasus>
Content-Type: multipart/alternative;
 boundary="------------020804000405050705000602"
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
Date: Tue, 23 Nov 2004 17:20:27 +0000

This is a multi-part message in MIME format.
--------------020804000405050705000602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcel,
    When I try to run the ./bootstrap command it comes back saying I 
need configure.ac or configure.in. Which should I use?

Dave Givens

Marcel Holtmann wrote:

>Hi Dave,
>
>  
>
>>    I am trying to get it to work with a Star TSP700 Thermal printer,
>>but I have also tried with an HP970CXI and a Canon i865.
>>    
>>
>
>please checkout the BlueZ libs2 CVS repository and run:
>
>	./bootstrap && ./configure && make
>	./test/sdptest records 00:00:... > file.txt
>
>And then send me that file.txt and also the output of "hcitool info".
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from real users.
>Discover which products truly live up to the hype. Start reading now. 
>http://productguide.itmanagersjournal.com/
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
>  
>

--------------020804000405050705000602
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
&nbsp;&nbsp;&nbsp; When I try to run the ./bootstrap command it comes back saying I
need configure.ac or configure.in. Which should I use?<br>
<br>
Dave Givens<br>
<br>
Marcel Holtmann wrote:<br>
<blockquote type="cite" cite="mid1101227784.27351.7.camel@pegasus">
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
<a class="moz-txt-link-freetext" href="http://productguide.itmanagersjournal.com/">http://productguide.itmanagersjournal.com/</a>
_______________________________________________
Bluez-users mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a>


  </pre>
</blockquote>
</body>
</html>

--------------020804000405050705000602--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
