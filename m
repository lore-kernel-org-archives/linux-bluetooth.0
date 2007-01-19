Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Fri, 19 Jan 2007 11:37:05 -0800
Message-ID: <D8CE9CFA707C894180BAC8CDD154F8460AF675C3@msiexch01.marvell.com>
From: "Quinton Yuan" <qyuan@marvell.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluez-devel Digest, Vol 9, Issue 77
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

Thanks, Brad, Frederic

1. I am using Music Angel from Windigo, former company I worked, and
it's based on CSR BC03MM, quite standard stereo headset, with same
setup, a2play works very well though 

2. I always login as root, and .a2dprc under home directory is the right
one I edit as it contains my right BD address,and debug flag work well.
My guess is timing control in new plugz causes this. I have played with
sbcbitpool value from 32 to 8, sample rate to 32, doesn't help, my UART
work at 2Mbps.

Regards/Quinton

-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net
[mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of
bluez-devel-request@lists.sourceforge.net
Sent: Friday, January 19, 2007 11:24 AM
To: bluez-devel@lists.sourceforge.net
Subject: Bluez-devel Digest, Vol 9, Issue 77

Send Bluez-devel mailing list submissions to
	bluez-devel@lists.sourceforge.net

To subscribe or unsubscribe via the World Wide Web, visit
	https://lists.sourceforge.net/lists/listinfo/bluez-devel
or, via email, send a message with subject or body 'help' to
	bluez-devel-request@lists.sourceforge.net

You can reach the person managing the list at
	bluez-devel-owner@lists.sourceforge.net

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Bluez-devel digest..."


Today's Topics:

   1. {subj190107} (Jessie Crawford)
   2. Re: Plugz issue (Brad Midgley)
   3. Re: Plugz issue (Fr?d?ric DALLEAU)
   4. {subj190107} (Lupe Mcguire)
   5. loading of hci_uart.ko (Choi Sonim)
   6. collarbone tubby (Montagu)


----------------------------------------------------------------------

Message: 1
Date: Fri, 19 Jan 2007 15:11:25 -0180
From: "Jessie Crawford" <unfaithfullysliver's@access2access.com>
Subject: [Bluez-devel] {subj190107}
To: <bluez-devel@lists.sf.net>
Message-ID: <01c73bdc$165f0b80$6c822ecf@unfaithfullysliver's>
Content-Type: text/plain;	charset="windows-1250"

No more scam or bullshit companies.
Look at charts and ask your broker about:

Ventana Medical Systems

Ventana Receives FDA Approval on Pathway

Thursday January 18, 10:08 am ET
Ventana Medical Systems Receives FDA Approval for Breast Cancer
Detection Test

TUCSON, Ariz. (AP) -- Ventana Medical Systems Inc., a maker of tissue
and slide preparation systems used in drug development, said Wednesday
it received Food and Drug Administration approval on a new antibody.
The company received the approval for its Pathway Her-2/neu (4B5) Rabbit
Monoclonal Antibody as an aid in assessing breast cancer patients being
considered for treatment with Herceptin. It is also approved for use on
the Ventana Image Analysis System.
Herceptin is a cancer treatment made by Genentech Inc. It targets HER-2,
which causes breast cancer cells to grow more rapidly. The approved
Pathway antibody is intended to detect the presence of the HER-2
antigen.

Get in before most investors hear about this awesome news!  VMSI has
just made an announcement which, once the investment community hears
about it, is going to send the issue rise!  Read on to find why we are
so excited!





------------------------------

Message: 2
Date: Fri, 19 Jan 2007 08:26:28 -0700
From: Brad Midgley <bmidgley@xmission.com>
Subject: Re: [Bluez-devel] Plugz issue
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <45B0E324.20506@xmission.com>
Content-Type: text/plain; charset=UTF-8

Quinton

>    4. XMMS playback speed issue seems tied to MMAP mode enabled,
disable
>       this mode will get the right playback speed, however, audio
still
>       break  every 2 or 3 seconds, any cue for this ?

which headset is this?

brad



------------------------------

Message: 3
Date: Fri, 19 Jan 2007 17:32:09 +0100
From: Fr?d?ric DALLEAU <frederic.dalleau@palmsource.com>
Subject: Re: [Bluez-devel] Plugz issue
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <45B0F289.9030601@palmsource.com>
Content-Type: text/plain; charset=UTF-8; format=flowed

Quinton,
>
> Thanks,
>
>    1. This flag still doesn?t work on my system,
>
I just tried a2dpd from plugz latest cvs and made sure the flags=1 is 
working.
Based on that, my guess is that you modified the wrong file. Are we ok 
that the file is located at  $HOME/.a2dprc
If you are using the daemon under another user than your desktop user 
for example (say root), the rc file would be in the home directory of 
that user) or you could use the -f option. The daemon don't need root 
privileges.
>
>    4. XMMS playback speed issue seems tied to MMAP mode enabled,
>       disable this mode will get the right playback speed, however,
>       audio still break  every 2 or 3 seconds, any cue for this ?
>
Audio breaks are mostly hardware related : I had different causes :
- Insufficient bandwith (for exemple, serial adapters set at 115k, or 
sbcbitpool too big)
- Headset don't like the sbcbitpool we provide.
- Bad adapter (I have one that does this with a bdaddr iof
11:11:11:11...)

So as Brad asked : what headset do you use?

BR, Fr?d?ric




------------------------------

Message: 4
Date: Fri, 19 Jan 2007 17:57:26 -0060
From: "Lupe Mcguire" <Epicurusranch@acarrow.com>
Subject: [Bluez-devel] {subj190107}
To: <bluez-devel@lists.sf.net>
Message-ID: <01c73bf3$47832fe0$6c822ecf@Epicurusranch>
Content-Type: text/plain;	charset="iso-8859-2"

No more bankrupts or shit companies.
Look at charts and ask your adviser about:

Ventana Medical Systems

Ventana Receives FDA Approval on Pathway

Thursday January 18, 10:08 am ET
Ventana Medical Systems Receives FDA Approval for Breast Cancer
Detection Test

TUCSON, Ariz. (AP) -- Ventana Medical Systems Inc., a maker of tissue
and slide preparation systems used in drug development, said Wednesday
it received Food and Drug Administration approval on a new antibody.
The company received the approval for its Pathway Her-2/neu (4B5) Rabbit
Monoclonal Antibody as an aid in assessing breast cancer patients being
considered for treatment with Herceptin. It is also approved for use on
the Ventana Image Analysis System.
Herceptin is a cancer treatment made by Genentech Inc. It targets HER-2,
which causes breast cancer cells to grow more rapidly. The approved
Pathway antibody is intended to detect the presence of the HER-2
antigen.

Get in before most investors hear about this awesome news!  VMSI has
just made an announcement which, once the investment community hears
about it, is going to send the issue rise!  Read on to find why we are
so excited!





------------------------------

Message: 5
Date: Fri, 19 Jan 2007 21:04:48 +0200
From: "Choi Sonim" <choisonim@gmail.com>
Subject: [Bluez-devel] loading of hci_uart.ko
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Message-ID:
	<4f436aae0701191104h376e9e89mca6769544b257e29@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

hi all,

I want to ask.
when I do "hciattach /dev/ttyS0 any", somehow the needed module
hci_uart.ko is loaded.
I looked in hciattach.c but I do not see how is it done.
can u please help me here ?

thank you very much all
choi.



------------------------------

Message: 6
Date: Fri, 19 Jan 2007 14:21:14 +0000
From: "Montagu" <zde@uniparinc.com>
Subject: [Bluez-devel] collarbone tubby
To: <bluez-devel@lists.sf.net>
Message-ID: <000d01c73bd5$64c8e9f0$6ec755d4@tky>
Content-Type: text/plain; charset="windows-1250"


Boiler Project Superintendents needed for OEM in Central Florida.
Required skills: Weapon guidance algorithms and guidance and control.
Describe your professional experience with software processes and
methodologies.
Do you have experience in the combustion industry? Experience in toll
plaza design a plus. Experience with MATLAB simulation is beneficial.
Candidate must be proficient in AutoCAD and 3D experience is a plus.
Additional exp and expertise should include piping design modifications,
exp working with equipment OEMs of heat transfer equipment with regards
to equipment replacement projects,. Please detail your overall roadway
- transportation engineering experience in the  private, commercial, and
public sectors.
What are your salary requirements for this position?
Experience with MATLAB simulation is beneficial. Required skills:
guidance and controls, navigation. Will be responsible for full profit
and loss of project, vendor and subcontractor management.
The Customer Service Representative position is a good entry-level
position for potential advancement to management. Candidate must be a
REGISTERED ARCHITECT.
Describe your automation, flow control, level measurement experience as
it relates to manufacturing environment. Do you have 5 years experience
in a manufacturing procurement environment?
Our client is looking for candidates that are local to the Daytona Beach
area or are willing to relocate on their own.
Candidate must have exp in field engineering support of heat transfer
equipment replacements at power plants.
Every client is important to our success and it is essential that our
clients experience a level of service that is superior to our
competition.
A basic understanding of missiles and projectiles is required.
After a sweeping election victory in December, Chavez began his third
term in office last week.
Explain your proficiency. Requires a BSME and 5 years of related
engineering experience in thermal fluids heat transfer. Our client will
provide references if needed.
A certificate in DoD Program Management or Systems Planning, Research,
and Development Engineering or equivalent is desired. What other design
software do you have a proficiency with?
Please describe in detail your experience with field measurements, area
surveys, and aerial maps.
Detail your relevant experience. Describe your experience designing
Process and Instrumentation diagrams. In order to be considered for this
position, the candidate MUST have a BS in Chemical or Mechanical or
Agricultural or Food Engineering.
Rate your skills with GIS, adlCPR, and list other computer programs you
are proficient with.
-------------- next part --------------
An HTML attachment was scrubbed...
URL:
http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel/attachmen
ts/20070119/1e0d3070/attachment.html 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: image/gif
Size: 31347 bytes
Desc: not available
Url :
http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel/attachmen
ts/20070119/1e0d3070/attachment.gif 

------------------------------

------------------------------------------------------------------------
-
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share
your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDE
V

------------------------------

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


End of Bluez-devel Digest, Vol 9, Issue 77
******************************************

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
