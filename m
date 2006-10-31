Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mayank BATRA <mayank.batra@st.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Tue, 31 Oct 2006 18:55:38 +0530
Message-ID: <004401c6fcf0$0e4fa8d0$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <d23110170608221347p37bc87a5mbdd1271eaf7631c3@mail.gmail.com>
Subject: Re: [Bluez-devel] Host Controller to Host Flow Control
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

Hi Marcel, Ulisses,

I am wondering whether this code(i.e. controller to host flow control) has
been included in one of the -mh kernel patch.
Can you please confirm?

Best Regards,
Mayank


Ulisses Furquim wrote:

> 
> Hi Marcel, Mayank,
> 
> how about something like the attached patch? I've used some of
> Mayank's code and added some other parts. It's not complete and it's
> only compile-tested yet.
> 
> I haven't done the interface to change the hci_dev->host_flow_ctl
> parameter from user space and we're sending the host number of
> completed packtes command after each packet (ACL or SCO, depending on
> the host_flow_ctl value). We're gonna need counters on both hci_dev
> and hci_conn structures to "ack" more than one packet and change
> hci_send_host_num_comp_pkts().
> 
> I'm also still not sure when we should send the host number of
> completed packets command. The specification says this command must be
> sent after the buffers are freed on the host but I don't know if we
> have to be strict about this. :-)
> 
> Best regards,
> 
> -- Ulisses
> 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
