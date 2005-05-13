Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050513143006.46889.qmail@web21125.mail.yahoo.com>
From: Vinod <geekvinod@yahoo.com>
Subject: Re: [Bluez-users] trouble setting up pand
To: bluez-users@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Fri, 13 May 2005 07:30:05 -0700 (PDT)

I looked at the /etc/syslog.conf file which pointed to
me that logging will be done at /var/log/messages but
that file has not been created at all on my ipaq 3870.
-------------------------------------------------------
syslog.conf
------------------------------------------------------

DESTINATION="buffer"            # log destinations
(buffer file remote)
MARKINT=20                      # intervall between
--mark-- entries
LOGFILE=/var/log/messages       # where to log (file)
#REMOTE=loghost:514             # where to log (syslog
remote)
REDUCE=no                       # reduce-size logging
ROTATESIZE=0                    # rotate log if grown
beyond X [kByte]
ROTATEGENS=3                    # keep X generations
of rotated logs
BUFFERSIZE=64                   # size of circular
buffer [kByte]
FOREGROUND=no                   # run in foreground
(don't use!)
------------------------------------------------------
Then i managed to get hcidump. From the GN i sent
l2ping packets to the slave and collected the dump at
the slave (i am not settign the GN to master mode as
suggested earlier, and that strange error about udhcpc
did not come today when i tried) . But how do i know
if i have a bnep0 interface? 

'ifconfig bnep0' still complains can't find interface.


This is my hcidump
-------------------------------------------------------
root@h3600:/etc/sysconfig# hcidump -t -s 200 -x
HCIDump - HCI packet analyzer ver 1.3
device: hci0 snap_len: 1028 filter: 0xffffffff
1115989643.724349 > HCI Event: Connect Request(0x04)
plen 10
  56 48 0D C7 02 00 12 01 12 01
1115989643.724806 < HCI Command: Accept Connection
Request(0x01|0x0009) plen 7
  56 48 0D C7 02 00 00
1115989643.731896 > HCI Event: Command Status(0x0f)
plen 4
  00 01 09 04
1115989643.923097 > HCI Event: Link Key Request(0x17)
plen 6
  56 48 0D C7 02 00
1115989643.923997 > HCI Event: Role Change(0x12) plen
8
  00 56 48 0D C7 02 00 00
1115989643.924365 < HCI Command: Link Key Request
Reply(0x01|0x000b) plen 22
  56 48 0D C7 02 00 3E 72 9A 20 84 47 50 BD 11 2E A7
39 D3 0C
  E9 34
1115989643.944396 > HCI Event: Command Complete(0x0e)
plen 10
  01 0B 04 00 56 48 0D C7 02 00
1115989644.134696 > HCI Event: Connect Complete(0x03)
plen 11
  00 28 00 56 48 0D C7 02 00 01 01
1115989644.135090 < HCI Command: Write Link Policy
Settings(0x02|0x000d) plen 4
  28 00 0F 00
1115989644.147288 > HCI Event: Max Slots Change(0x1b)
plen 3
  28 00 05
1115989644.147934 > HCI Event: Command Complete(0x0e)
plen 6
  01 0D 08 00 28 00
1115989644.148304 < HCI Command: Change Connection
Packet Type(0x01|0x000f) plen
 4
  28 00 18 CC
1115989644.158102 > ACL data: handle 0x0028 flags 0x02
dlen 28
    L2CAP(s): Echo req: dlen 20
    45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55
56 57 58
1115989644.158358 < ACL data: handle 0x0028 flags 0x02
dlen 28
    L2CAP(s): Echo rsp: dlen 20
    45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55
56 57 58
1115989644.160780 > HCI Event: Command Status(0x0f)
plen 4
  00 01 0F 04
1115989644.161697 > HCI Event: Connection Packet Type
Changed(0x1d) plen 5
  00 28 00 18 CC
1115989644.170652 > HCI Event: Number of Completed
Packets(0x13) plen 5
  01 28 00 01 00
-------------------------------------------------------

I might have to try albert's suggestion though i
remember reading elsewhere about some folks who used
the same familiar distribution and got pand working.
Things are more difficult for me as i only have a
'scattered knowledge' of linux as of now. So bear with
me plz.

Vinod
  --- Albert Huang <ashuang@gmail.com> wrote:
> Try using a different release of familiar.
> 
> I believe bluetooth support is broken in familiar
> 0.8.1 and 0.8.2.  We
> were unable to get bluetooth working on a H5550 or
> H3800 and
> encountered inexplicable errors that did not appear
> on other versions
> of familiar and on x86 machines.
> 
> I recommend pb's unstable16 build that he made about
> a year ago.  You
> can find that.here:
> http://handhelds.org/~pb/unstable/old/
> 
> -albert
> 
> On 5/12/05, Vinod <geekvinod@yahoo.com> wrote:
> > 
> > > > 1) modprobe bnep's on both ipaqs
> > > > 2) set one as master and confirmed it
> > > > 3) pand --listen --role GN on the master
> > > > 4) pand --connect 'master-address' which i got
> > > from
> > > > hcitool scan
> > >
> > > skip step 2, because it may cause troubles.
> > 
> > tried skipping step 2 and set both back as
> > slaves,resulting in same error.
> > 
> > > > Then i get the following message
> > > >
> > > > root@h3600:/etc/bluetooth# udhcpc[29501]:
> udhcpc
> > > > (v0.9.9-pre) started
> > > > udhcpc[29501]: SIOCGIFINDEX failed!: No such
> > > device
> > >
> > > What else do you see in the syslog. Run "hcidump
> -X
> > > -V" as root to check
> > > the BNEP connection setup.
> > Unfortunately the latest familiar version(0.8.2),
> > which i have, does not have hcidump in its linux
> > distribution. And i still havent figured a way out
> to
> > compile with gcc on my ipaq. is there any other
> other
> > way to check bnep0 status? Doing ifconfig bnep0
> > returns
> > 
> > ifconfig bnep0
> > ifconfig: bnep0: error fetching interface
> information:
> > Device not found
> > 
> > So i believe bnep connection does not exist.
> > 
> > would appreciate if you let me know if any other
> > workaround exists until i figure out a way to run
> make
> > on my ipaq.
> > 
> > Vinod
> > 
> > Yahoo! Mail
> > Stay connected, organized, and protected. Take the
> tour:
> > http://tour.mail.yahoo.com/mailtour.html
> > 
> > 
> >
>
-------------------------------------------------------
> > This SF.Net email is sponsored by Oracle Space
> Sweepstakes
> > Want to be the first software developer in space?
> > Enter now for the Oracle Space Sweepstakes!
> >
>
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> >
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
> 
> 
>
-------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space
> Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_ids93&alloc_id281&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 


		
Yahoo! Mail
Stay connected, organized, and protected. Take the tour:
http://tour.mail.yahoo.com/mailtour.html



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
