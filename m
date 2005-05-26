Return-Path: <steve.crane@rococosoft.com>
Subject: Re: [Bluez-devel] Re: Small fix for L2CAP MTU
From: Stephen Crane <steve.crane@rococosoft.com>
To: bluez-devel@lists.sourceforge.net
Cc: jim.oleary@rococosoft.com, marcel@holtmann.org
In-Reply-To: <1117103519.12036.35.camel@pegasus>
References: <1117032099.5854.56.camel@baroque.rococosoft.com>
	 <1117036775.30044.238.camel@pegasus>
	 <1117102401.5854.75.camel@baroque.rococosoft.com>
	 <1117103519.12036.35.camel@pegasus>
Content-Type: multipart/mixed; boundary="=-meEpNYL7xQycquDl2MQB"
Date: Thu, 26 May 2005 14:55:29 +0100
Message-Id: <1117115729.15042.100.camel@baroque.rococosoft.com>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>


--=-meEpNYL7xQycquDl2MQB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Marcel,

On Thu, 2005-05-26 at 12:31 +0200, Marcel Holtmann wrote:
> Hi Steve,
> 
> > I've attached the two dump files. Let me know if you need any more info.
> 
> I don't see it. No side is asking for a MTU with the size 50 in the
> configuration process of the L2CAP connection setup.

Sorry if I was unclear. The fix causes the omtu to be set to the peer's
value, only if we don't care about the omtu. No further negotiation is
performed.

I have attached a pair of test programs which highlight this:
* listener sets imtu and omtu to be 512
* connector connects to its first argument, setting omtu to the value of
its second argument.

Without the patch, the output of connector is:
$ ./connector 00:80:98:24:4F:19 50
imtu=672 omtu=512

With the patch, its output is:
$ ./connector 00:80:98:24:4F:19 50
imtu=672 omtu=50

Does this make sense?

Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)

--=-meEpNYL7xQycquDl2MQB
Content-Disposition: attachment; filename=connector.c
Content-Type: text/x-csrc; name=connector.c; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

#include <sys/socket.h>
#include <netinet/in.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>
#include <bluetooth/l2cap.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
	struct sockaddr_l2 addr;
	int s = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
	int opt, n;
   struct l2cap_options opts;
   char buf[1024];
   int mtu = atoi(argv[2]);

	if (0 > s) {
		perror("socket");
		return -1;
	}
   opt = sizeof(struct l2cap_options);
   opts.imtu = L2CAP_DEFAULT_MTU;
   opts.omtu = mtu;
   if (0 > setsockopt(s, SOL_L2CAP, L2CAP_OPTIONS, &opts, opt)) {
      perror("setsockopt(l2cap)");
      close(s);
      return -1;
   }
	addr.l2_psm = htobs(0x1001);
	addr.l2_family = AF_BLUETOOTH;
	baswap(&addr.l2_bdaddr, strtoba(argv[1]));
	if (0 > connect(s, (struct sockaddr *)&addr, sizeof(addr))) {
		perror("connect");
		return -1;
	}
   if (0 > getsockopt(s, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt)) {
      perror("getsockopt");
      return -1;
   }
   printf("imtu=%d omtu=%d\n", opts.imtu, opts.omtu);
   n = sizeof(buf);
   if (mtu == 0)
      n = opts.omtu;
   else if (n > mtu)
      n = mtu;
   n = write(s, buf, n);
   if (0 > n) {
      perror("write");
      return -1;
   }
   printf("wrote %d bytes\n", n);
   close(s);
	return 0;
}

--=-meEpNYL7xQycquDl2MQB
Content-Disposition: attachment; filename=listener.c
Content-Type: text/x-csrc; name=listener.c; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

#include <unistd.h>
#include <malloc.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>
#include <bluetooth/l2cap.h>

int main(int argc, char *argv[])
{
	int l = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
	struct sockaddr_l2 addr;
	int opt = 0;
	int s, addr_len, n;
   struct l2cap_options opts;
   char buf[1024];

	if (0 > l) {
		perror("socket");
		return -1;
	}
	memset(&addr, 0, sizeof(addr));
	addr.l2_family = AF_BLUETOOTH;
	addr.l2_psm = htobs(0x1001);
	bacpy(&addr.l2_bdaddr, BDADDR_ANY); 
	if (0 > bind(l, (struct sockaddr *)&addr, sizeof(addr))) { 
		perror("bind");
		return -1;
	}
   opts.imtu = 512;
   opts.omtu = 512;
   if (0 > setsockopt(l, SOL_L2CAP, L2CAP_OPTIONS, &opts, sizeof(opts))) {
      perror("setsockopt(l2cap)");
      close(s);
      return -1;
   }
	if (0 > listen(l, 10)) {
		perror("listen");
		return -1;
	}
	s = accept(l, (struct sockaddr *)&addr, &addr_len);
	if (0 > s) {
		perror("accept");
		return -1;
	}
	if (0 > getpeername(s, (struct sockaddr *)&addr, &addr_len)) {
		perror("getpeername");
		return -1;
	}
	printf("got connection from %s\n", batostr(&addr.l2_bdaddr));
   opt = sizeof(struct l2cap_options);
   if (0 > getsockopt(s, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt)) {
      perror("getsockopt");
      return -1;
   }
   printf("imtu=%d omtu=%d\n", opts.imtu, opts.omtu);
   n = read(s, buf, sizeof(buf));
   if (0 > n) {
      perror("read");
      return -1;
   }
   printf("read %d bytes\n", n);
   close(s);
   close(l);
	return 0;
}

--=-meEpNYL7xQycquDl2MQB--
