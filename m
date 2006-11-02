Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 2 Nov 2006 14:05:03 +0100 (CET)
From: Peter Wippich <pewi@gw-instruments.de>
To: Rupesh Gujare <rupesh_gujare@rediffmail.com>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20061102122856.28888.qmail@webmail9.rediffmail.com>
Message-ID: <Pine.LNX.4.63.0611021358540.16704@redbean.intranet.gw-instruments.de>
References: <20061102122856.28888.qmail@webmail9.rediffmail.com>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Need Help In SDP Programming......
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Hello Rupesh, 

On Thu, 2 Nov 2006, Rupesh Gujare wrote:

>   
> Thanks Peter and Mingfan for your suggestions and code review. I will 
> definately try to improve on it. 
>   I am currently working on 2.6.15 kernel. and had not applied any patch.
>  I will like to ask peter that which kernel you are using? Are you facing same problem after patching to latest kernel?
>   Do let me know.
>   Thanks and regards.
>  Rupesh

The concurrency problem Mingfan talked about is not what causes your 
problem. This would only show up when you use multiple threads to do 
concurrent SDP connections, and you use a single thread. 

I observed something similar as you with an unpatched 2.6.14 kernel. 
Because this was on an embedded platform I have not tried newer versions 
(this simply causes to much work just for a try). 

Ciao, 

Peter 


|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
