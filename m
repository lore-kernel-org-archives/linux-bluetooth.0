Return-Path: <steve.crane@rococosoft.com>
Subject: EBADFD on RFComm connect
From: Stephen Crane <steve.crane@rococosoft.com>
To: bluez-devel@lists.sourceforge.net
Cc: maxk@qualcomm.com, marcel@rvs.uni-bielefeld.de
Message-Id: <1058880571.1670.425.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Date: 22 Jul 2003 14:29:31 +0100
Content-Type: multipart/mixed; boundary="=-fboUleXsgZ6OjK+RECcM"
List-ID: <bluez-devel.lists.sourceforge.net>


--=-fboUleXsgZ6OjK+RECcM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Hi Max, Marcel,
Under what circumstances can connect() return EBADFD?

I have a couple of programs (attached) one of which opens a listening
socket and accepts 32 connections. The other loops attempting 32
connections to the same channel. On the second connection connect()
always fails with EBADFD. (If I leave in the 0.5 second delay it all
works fine.)

I've also attached hcidumps from each machine --- each is running kernel
2.4.21-mh2.

Thanks,
Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)

--=-fboUleXsgZ6OjK+RECcM
Content-Disposition: attachment; filename=connector.c
Content-Transfer-Encoding: 7bit
Content-Type: text/x-c; NAME=connector.c; CHARSET=ISO-8859-15

#include <sys/socket.h>
#include <netinet/in.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>
#include <unistd.h>
#include <errno.h>

int main(int argc, char *argv[])
{
	struct sockaddr_rc addr;
	int addr_len = sizeof(addr);
	int i;

	addr.rc_channel = 2;
	addr.rc_family = AF_BLUETOOTH;
	baswap(&addr.rc_bdaddr, strtoba(argv[1]));
	for (i = 0; i < 32; i++) {
		int s = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
		char c;
		while (0 > connect(s, (struct sockaddr *)&addr, sizeof(addr)))
			if (errno != EBUSY) {
				perror("connect");
				return -1;
			}
		printf("connected %d\n", i);
		read(s, &c, 1);
		close(s);
//		usleep(500000);
	}
	return 0;
}

--=-fboUleXsgZ6OjK+RECcM
Content-Disposition: attachment; filename=listener.c
Content-Transfer-Encoding: 7bit
Content-Type: text/x-c; NAME=listener.c; CHARSET=ISO-8859-15

#include <unistd.h>
#include <malloc.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>

int main(int argc, char *argv[])
{
	int l = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
	struct sockaddr_rc addr, myaddr;
	int i, addr_len = sizeof(addr);

	if (0 > l) {
		perror("socket");
		return -1;
	}
	memset(&addr, 0, sizeof(addr));
	addr.rc_family = AF_BLUETOOTH;
	addr.rc_channel = 2;
	bacpy(&addr.rc_bdaddr, BDADDR_ANY); 
	if (0 > bind(l, (struct sockaddr *)&addr, sizeof(addr))) { 
		perror("bind");
		return -1;
	}
	if (0 > listen(l, 10)) {
		perror("listen");
		return -1;
	}
	for (i=0; i < 32; i++) {
		int s = accept(l, (struct sockaddr *)&addr, &addr_len);
		char c;
		if (0 > s) {
			perror("accept");
			return -1;
		}
		printf("accepted %d\n", i);
		write(s, &c, 1);
		close(s);
	}
	return 0;
}

--=-fboUleXsgZ6OjK+RECcM
Content-Disposition: attachment; filename=connect
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream; NAME=connect

EQAAAP05HT8pLQgAAQUEDRlPJJiAABjMAQAAAAEHAAEA/TkdP5tNCAAEDwQAAQUEDgABAP85HT9j
gw4ABAMLACgAGU8kmIAAAQARAAAA/zkdP0+HDgACKCAMAAgAAQACAQQAAwBAAAgAAAD/OR0/dIcO
AAENCAQoAA8ACAABAP85HT/fmg4ABBMFASgAAQAGAAEA/zkdP+HBDgAEGwMoAAUJAAEA/zkdP83F
DgAEDgYBDQgAKAAVAAEAADodPyiNAAACKCAQAAwAAQADAQgAQABAAAAAAAAVAAAAADodPySRAAAC
KCAQAAwAAQAEAggAQAAAAAECAAQIAAEAADodP5ikAAAEEwUBKAABABMAAQAAOh0/VwIBAAIoIA4A
CgABAAUCBgBAAAAAAAAVAAEAADodPycOAQACKCAQAAwAAQAEAQgAQAAAAAECAAQTAAAAADodP2YO
AQACKCAOAAoAAQAFAQYAQAAAAAAADQAAAAA6HT+ODgEAAiggCAAEAEAAAz8BHAgAAQAAOh0/Xy0B
AAQTBQEoAAEACAABAAA6HT8eNQEABBMFASgAAQANAAEAADodP1l/AQACKCAIAAQAQAADcwHXFwAA
AAA6HT+SfwEAAiggEgAOAEAAA+8VgxEE8AcA+wMAB3AIAAEAADodP5WeAQAEEwUBKAABABYAAQAA
Oh0/gaIBAAIoIBEADgBAAAHvFYERBOAHAPsDAAcGAAEAADodP2aqAQACKBABAKoNAAAAADodP66q
AQACKCAIAAQAQAATPwGWCAABAAA6HT/AwQEABBMFASgAAQANAAEAADodP64XAgACKCAIAAQAQAAT
cwFdEQAAAAA6HT/qFwIAAiggDAAIAEAAA+8J4wUTjXARAAEAADodP2ojAgACKCAMAAgAQAAB7wnj
BRONqhEAAAAAOh0/rSMCAAIoIAwACABAAAPvCeEFE41wCAABAAA6HT8fLwIABBMFASgAAQAIAAEA
ADodP9o6AgAEEwUBKAABABEAAQAAOh0/yD4CAAIoIAwACABAAAHvCeEFE42qDgAAAAA6HT8OPwIA
AiggCQAFAEAAE/8BIXkOAAEAADodP3tKAgACKCAJAAUAQAAR/wEhow4AAQAAOh0/TlICAAIoIAkA
BQBAABHvA7+/DQAAAAA6HT8QUwIAAiggCAAEAEAAE1MBdwgAAQAAOh0//l0CAAQTBQEoAAEADQAB
AAA6HT8KXgIAAiggCAAEAEAAEVMBFg0AAAAAOh0/RF4CAAIoIAgABABAABFzATwNAAAAADodP1te
AgACKCAIAAQAQAADUwH9EQAAAAA6HT9oXgIAAiggDAAIAAEABgMEAEAAQAAIAAEAADodP4dxAgAE
EwUBKAABAAgAAQAAOh0/VXkCAAQTBQEoAAEACAABAAA6HT8lgQIABBMFASgAAQANAAEAADodPyyB
AgACKCAIAAQAQAATcwFdCAABAAA6HT8hhQIABBMFASgAAQANAAEAADodPyyFAgACKCAIAAQAQAAT
HwG8DQABAAA6HT/gjAIAAiggCAAEAEAAA3MB1xEAAQAAOh0/w5ACAAIoIAwACAABAAcDBABAAEAA
BwAAAAI6HT/FcgIAAQYEAygAEwcAAQACOh0/xowCAAQPBAABBgQHAAEAAjodPy/PAgAEBQQAKAAW


--=-fboUleXsgZ6OjK+RECcM
Content-Disposition: attachment; filename=listen
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream; NAME=listen

DQABAIA7HT/onw4ABAQKF08kmIAAAAEAAQsAAACAOx0/nLcOAAEJBAcXTySYgAABBwABAIA7HT/P
9Q4ABA8EAAEJBA4AAQCBOx0/cF8AAAQDCwAoABdPJJiAAAEACAAAAIE7HT9kYwAAAQ0IBCgADwAJ
AAEAgTsdP5+pAAAEDgYBDQgAKAAIAAAAgTsdP7KtAAABDwQEKAAYzAYAAQCBOx0/1fMAAAQbAygA
BQcAAQCBOx0/sfcAAAQPBAABDwQIAAEAgTsdP5n7AAAEHQUAKAAYzBEAAQCBOx0/Ez4BAAIoIAwA
CAABAAIBBAADAEAAFQAAAIE7HT/5QQEAAiggEAAMAAEAAwEIAEAAQAAAAAAACAABAIE7HT9lqwEA
BBMFASgAAQAVAAEAgTsdPxm3AQACKCAQAAwAAQAEAggAQAAAAAECAAQTAAAAgTsdP6vDAQACKCAO
AAoAAQAFAgYAQAAAAAAAFQAAAIE7HT+6wwEAAiggEAAMAAEABAEIAEAAAAABAgAECAABAIE7HT+S
IAIABBMFASgAAQAIAAEAgTsdP1YoAgAEEwUBKAABABMAAQCBOx0/+jcCAAIoIA4ACgABAAUBBgBA
AAAAAAANAAEAgTsdP7lDAgACKCAIAAQAQAADPwEcDQAAAIE7HT/3QwIAAiggCAAEAEAAA3MB1wgA
AQCBOx0/dqECAAQTBQEoAAEAFgABAIE7HT9YpQIAAiggEQAOAEAAA+8VgxEE8AcA+wMABwYAAQCB
Ox0/PakCAAIoEAEAcBcAAACBOx0/fqkCAAIoIBIADgBAAAHvFYERBOAHAPsDAAeqCAABAIE7HT97
yAIABBMFASgAAQANAAEAgTsdPzTUAgACKCAIAAQAQAATPwGWDQAAAIE7HT9k1AIAAiggCAAEAEAA
E3MBXREAAACBOx0/ctQCAAIoIAwACABAAAHvCeMFE42qCAABAIE7HT/fNQMABBMFASgAAQAIAAEA
gTsdP6c9AwAEEwUBKAABABEAAQCBOx0/kkEDAAIoIAwACABAAAPvCeMFE41wEQAAAIE7HT/BQgMA
AiggDAAIAEAAAe8J4QUTjaoRAAEAgTsdP15NAwACKCAMAAgAQAAD7wnhBRONcA4AAACBOx0/s00D
AAIoIAkABQBAABH/ASGjDgAAAIE7HT/FTQMAAiggCQAFAEAAEe8Dv78NAAAAgTsdP9FNAwACKCAI
AAQAQAARUwEWCAABAIE7HT/TYAMABBMFASgAAQAIAAEAgTsdP3BwAwAEEwUBKAABAA4AAQCBOx0/
enADAAIoIAkABQBAABP/ASF5CAABAIE7HT9WdAMABBMFASgAAgANAAEAgTsdPyl8AwACKCAIAAQA
QAATUwF3DQAAAIE7HT9ZfAMAAiggCAAEAEAAE3MBXQ0AAQCBOx0/3YcDAAIoIAgABABAABFzATwN
AAAAgTsdPwGIAwACKCAIAAQAQAATHwG8DQABAIE7HT/EiwMAAiggCAAEAEAAA1MB/Q0AAACBOx0/
5osDAAIoIAgABABAAANzAdcRAAEAgTsdP32XAwACKCAMAAgAAQAGAwQAQABAABEAAACBOx0/nZcD
AAIoIAwACAABAAcDBABAAEAACAABAIE7HT8FqwMABBMFASgAAwAIAAEAgTsdP+muAwAEEwUBKAAB
AAcAAQCDOx0/G0AFAAQFBAAoABM=

--=-fboUleXsgZ6OjK+RECcM--
