Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <2de4657604120104274918f56@mail.gmail.com>
From: Manjunath Prabhu <manjunath.mp@gmail.com>
To: pws@csr.com
Subject: Re: [Bluez-users] Test Mode
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <200412011028.iB1ASZIk030820@news01.csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <2de4657604113010234e4e3a3f@mail.gmail.com>
	 <1101882666.18840.23.camel@pegasus>
	 <200412011028.iB1ASZIk030820@news01.csr.com>
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
Date: Wed, 1 Dec 2004 17:57:48 +0530

Hi peter,
Thanks for the reply. What scenario should i be looking for inorder to
set up these tests. Can I conduct the tests using my dongle as a slave
and a  CATC or Frontline or a Mobiwave BT trainer/protocol analyser as
the Master.  Will I be able to modify the baseband to suite my needs? 
Do they have a provision for fusing new codes (something like a
flash)??
I think i better write to the sales person from respective organisations....

regards,
manjunath

On Wed, 01 Dec 2004 10:28:34 +0000, Peter Stephenson <pws@csr.com> wrote:
> 
> 
> > The LMP specification speaks about the Test Mode and Methodology
> > saying that Adaptive power control, adaptive freq hopping scenarios
> > can be imitated provided the respective LMP PDU's are sent.
> >
> > How do I make the HCI commands initiate these LMP PDU's? The HCI
> > specification have only the "Test Enable" and "Read and Write
> > Loopback"  test commands but other no commands which will result in
> > inititating the LM to the testing modes. How do i conduct these
> > adaptive tests?
> 
> It's quite deliberate that the only thing you can do with a production
> device is put it into test mode as a slave
> (HCI_Enable_Device_Under_Test_Mode), requiring all test instructions to
> be sent from the master.  To do the test end you need a specialist
> tester.  These tend to be expensive since they're aimed at manufacturers
> doing a lot of testing.
> 
> You can use local and remote loopback without any extra hardware
> support, however.  They are completely separate from the test modes you
> are talking about.
> 
> Since the features aren't available over HCI, you need to ask somewhere
> else.  However, if you're looking for a cheap way of using the Bluetooth
> test modes you're probably out of luck.  Most manufacturers (including
> us) provide some simplified but non-standard test commands you can run
> between two modules for RF testing and characterisation.
> 
> --
> Peter Stephenson <pws@csr.com>                  Software Engineer
> CSR PLC, Churchill House, Cambridge Business Park, Cowley Road
> Cambridge, CB4 0WZ, UK                          Tel: +44 (0)1223 692070
> 
> **********************************************************************
> This email and any files transmitted with it are confidential and
> intended solely for the use of the individual or entity to whom they
> are addressed. If you have received this email in error please notify
> the system manager.
> 
> This footnote also confirms that this email message has been swept by
> MIMEsweeper for the presence of computer viruses.
> 
> www.mimesweeper.com
> **********************************************************************
> 
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
