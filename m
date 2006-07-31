Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060731185815.56428.qmail@web51403.mail.yahoo.com>
Date: Mon, 31 Jul 2006 11:58:15 -0700 (PDT)
From: manojt ambe <mp_tambe@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1154369720.4982.11.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Subject: Re: [Bluez-users] rfcomm connection disconnects immediately
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Marcel,
The sdptool records showed following services
supported by the headset: Headset(chan 1),
Headset-support(2) and serial port services(chan 3).  


I modified channel to 3 from 1 and now it is able to
connect. But getsockopt shows following error.

Can't get RFCOMM connection information: Protocol not
available (92)
Connected [handle 0, class 0x000000]
I have pasted function below.

regards,
Manoj

int BTPushBtnDaemon::rfcomm_connect(bdaddr_t *src,
bdaddr_t *dst, uint8_t channel)
{
  struct sockaddr_rc addr;
  int s;
  struct rfcomm_conninfo conn;
  socklen_t optlen;


  if ((s = socket(PF_BLUETOOTH, SOCK_STREAM,
BTPROTO_RFCOMM)) < 0) {
     fprintf(stderr, "Create socket error %d\n",s);
     return -1;
  }
  fprintf(stderr, "Socket %d\n",s);

  memset(&addr, 0, sizeof(addr));
  addr.rc_family = AF_BLUETOOTH;
  bacpy(&addr.rc_bdaddr, src);
  addr.rc_channel = 3;
  if (bind(s, (struct sockaddr *)&addr, sizeof(addr))
< 0) {
     fprintf(stderr, "Bind socket error ");
     ::close(s);
      return -1;
  }

  memset(&addr, 0, sizeof(addr));
  addr.rc_family = AF_BLUETOOTH;
  bacpy(&addr.rc_bdaddr, dst);
  addr.rc_channel = 3;
  if (connect(s, (struct sockaddr *)&addr,
sizeof(addr)) < 0 ){
     fprintf(stderr, "Connect socket error ");
     ::close(s);
     return -1;
  }

   /* Get connection information */
    memset(&conn, 0, sizeof(conn));
    optlen = sizeof(conn);

    if (getsockopt(s, SOL_RFCOMM, RFCOMM_CONNINFO,
&conn, &optlen) < 0) {
       fprintf(stderr, "Can't get RFCOMM connection
information: %s (%d)\n", strerror(errno), errno);
        }

        fprintf(stderr, "Connected [handle %d, class
0x%02x%02x%02x]\n",
                conn.hci_handle,
                conn.dev_class[2], conn.dev_class[1],
conn.dev_class[0]);

  fprintf(stderr, "Socket %d\n",s);
  return s;
}


--- Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi,
> 
> > I did find sdptool browse command to search for
> rfcomm
> > channel for various services. But SDPTool output
> is
> > always empty. Why is this? Pls let me know. 
> 
> if the remote side doesn't support a public browse
> group then you won't
> see any records. In this case you have to explicitly
> search for a
> specific service with "sdptool search ...".
> 
> Regards
> 
> Marcel
> 
> 
> 
>
-------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get
> the chance to share your
> opinions on IT & business topics through brief
> surveys -- and earn cash
>
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
