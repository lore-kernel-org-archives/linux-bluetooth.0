Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Message-ID: <pan.2005.01.12.16.28.16.406386@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] playing with handsfree program
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 12 Jan 2005 17:28:17 +0100

Hi,

I am trying to use handsfree-040326.tar.gz from
http://140.78.95.100/~vogl/bluez/ to emulate a handsfree device with my
computer and BT adapter. 
I recompiled the program and tried to execute it but I receive imediately
a:
 ./handsfree test.wav 00:60:57:80:84:71 12
Voice setting: 0x0060
Can't connect RFCOMM channel: Invalid argument

I think it is because of recent changes in bluez-libs and utilities,
because a " rfcomm connect hci0 MY_BT_ADDR 12 " works just fine.

The problem I think is in rfcomm_connect() function from handsfree.c. I
will try to do more tests, but if somebody has an idea what might be
wrong, I will apreciate a hint.

I copy here the rfcomm_connect() function for readability.

static int rfcomm_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t channel)
{
    struct sockaddr_rc addr;
    int s;

    if ((s = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0) {
        return -1;
    }

    memset(&addr, 0, sizeof(addr));
    addr.rc_family = AF_BLUETOOTH;
    bacpy(&addr.rc_bdaddr, src);
    addr.rc_channel = 0;
    if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
        close(s); 
        return -1;
    }

    memset(&addr, 0, sizeof(addr));
    addr.rc_family = AF_BLUETOOTH;
    bacpy(&addr.rc_bdaddr, dst);
    addr.rc_channel = channel;
    if (connect(s, (struct sockaddr *)&addr, sizeof(addr)) < 0 ){
        close(s); 
        return -1;
    }

    return s;
}




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
