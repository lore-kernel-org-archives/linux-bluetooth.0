Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <452DCBF2.9010806@xmission.com>
Date: Wed, 11 Oct 2006 23:00:34 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] a2dp from the ground up
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

Hey

My notes I wrote up as I got the a2dp plugin running on a blank ubuntu
machine are here. I will be putting these in the new docs (and hopefully
the new docs can make the sco alsa plugin the place to start for sco)

Any idea why I had to change the pin helper before things would pair? Is
that a common problem?

=======================================================================

btsco from the ground up

get ubuntu/debian packages:

apt-get install build-essential libbluetooth2-dev automake autoconf cvs
libtoolize libasound2-dev xmms

get & install libsbc:

cvs -d:pserver:anonymous@sbc.cvs.sourceforge.net:/cvsroot/sbc login
cvs -d:pserver:anonymous@sbc.cvs.sourceforge.net:/cvsroot/sbc co sbc
cd sbc
./bootstrap
./configure --prefix=/usr
make
sudo make install

get btsco:
cvs -d:pserver:anonymous@btsco.cvs.sourceforge.net:/cvsroot/btsco login
cvs -d:pserver:anonymous@btsco.cvs.sourceforge.net:/cvsroot/btsco co btsco
./bootstrap
./configure --prefix=/usr --enable-alsaplugin
make
sudo make install

cp alsa-plugins/sample.a2dprc ~/.a2dprc

edit ~/.a2dprc to contain the address of your headset on the address= line.

create ~/.asoundrc with simply:

pcm.a2dpd {
        type a2dpd
}

run xmms, go to prefs (control-p), change output to alsa, click
configure, change device from
 default
to
 a2dpd
and click [use software volume control]

If this is a combo headset, just turn off the phone it's going to try to
connect with first! (You can tinker with multiple connections later but
keep it simple for starters)

Turn the headset on in pair mode.

Run a2dpd:
 a2dpd

and hit play in xmms. On the first connect, you should get a popup
asking for the pin. Then audio should start.

If your set can do AVRCP, it will be set up to do track
advance/pause/stop/play through xmms command-line control.

Troubleshooting

If you get all kinds of connection refused errors from a2dpd, you may
have to change pin_helper in /etc/bluetooth/hcid.conf:

pin_helper /usr/bin/bluez-pin;

and reboot or run
 /etc/init.d/bluez-utils restart

Brad

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
