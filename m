Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Collin R. Mulliner" <collin@betaversion.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] RFComm dynamic channel allocation
Message-Id: <20040708150256.242ad7f3@coredump>
In-Reply-To: <1085138236.2777.10.camel@baroque.rococosoft.com>
References: <1085138236.2777.10.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 8 Jul 2004 15:02:56 +0200

Hi,

does the dynamic rfcomm channel allocation work? I'm running 2.6.7-mh1
and I allways get channel 1, which is used (listend and connected) by a
other process. I don't get any error it just binds and listens on
channel 1.

cat /proc/bluetooth/rfcomm/sock 

/* created thru: rfcomm listen /dev/rfcomm0 1 */
00:00:00:00:00:00 00:00:00:00:00:00 4 1
00:00:00:00:00:00 00:00:00:00:00:00 2 0
/* created thru: running my server */
xx:xx:xx:xx:xx:xx 00:00:00:00:00:00 4 1

my code:

server_sa.rc_family = AF_BLUETOOTH;
server_sa.rc_channel = channel;		
server_sa.rc_bdaddr = self.addr;

if (bind(server, (struct sockaddr*) &server_sa, sizeof(server_sa)) < 0){
 return(-1);
}
		
if (listen(server, 1) < 0) {
 return(-1);
}
	
if (channel == 0) {
 remote_len = sizeof(struct sockaddr_rc);
 memset(&remote_sa, 0, sizeof(struct sockaddr_rc));
 if (getsockname(server, (struct sockaddr*) &remote_sa, &remote_len) <
	0) {
  return(-1);
 }

 channel = remote_sa.rc_channel;
 printf("bt_server(): channel %d\n", remote_sa.rc_channel);		}
			
thanks ... Collin

-- 
Collin R. Mulliner <collin@betaversion.net>
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
To know recursion, you must first know recursion.


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
