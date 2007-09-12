Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Wed, 12 Sep 2007 22:01:06 +0800
Message-ID: <7A4442F6D7BAD14292CEBFD4A76E31A703D118E9@ZMY16EXM66.ds.mot.com>
In-Reply-To: <1189451071.687.48.camel@violet>
From: "Venkata Sreedhara Deekshitulu Mantha-a22595" <deekshitulu@motorola.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluez Stack compilation for broadcom board
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Marcel,
 ThankQ for the suggestion. I have a OMAP linux board with 2.4.18 kernel
version, the compiler we are using is arm_v5t_le-gcc and a broadcom
bluetooth board BCM2045.
 I have the following bluez packages: bluez-libs-3.2 and
bluez-utils-3.2. This BlueZ is compiled and installed, and is running
fine for CSR Casira blue box connected through serial port. Now I have
to recompile BlueZ for broadcom board, so that I should be able to bring
up the board, using command - "hciattach".
 Currently, we are compiling and installing BlueZ for CSR chip as given
below:

========================================================================
==========
# patch bluez library sources
patch -d bluez-libs-3.2 -p1 < ../src/packages/bluez-libs-3.2.patch

# set environment variables
export CC=arm_v5t_le-gcc
export LD=arm_v5t_le-ld
export AR=arm_v5t_le-ar
export RANLIB=arm_v5t_le-ranlib
export STRIP=arm_v5t_le-strip

# configure bluez lib
cd bluez-libs-3.2
./configure --prefix=$TOOLS_TARGET_FOLDER/usr
--host=arm_v5t_le-linux-gnu

# make bluez library and install
make
sudo make install

# extract bluez utils
tar xfvz ../src/packages/bluez-utils-3.2.tar.gz

# make hciconfig, hciattach, hcitool and sdptool
cd bluez-utils-3.2/tools
arm_v5t_le-gcc -v -o hciconfig hciconfig.c csr.c ../common/textfile.c
-I../common -DSTORAGEDIR="\"/usr/etc\"" -lbluetooth
arm_v5t_le-gcc -v -o hciattach hciattach.c hciattach_st.c -lbluetooth
arm_v5t_le-gcc -v -o hcitool hcitool.c ../common/oui.c
../common/textfile.c -I../common -DVERSION="3.9"
-DSTORAGEDIR="\"/usr/etc\"" -lbluetooth
arm_v5t_le-gcc -v -DVERSION="\"3.2\"" -o sdptool sdptool.c -lbluetooth
cd ../sdpd
arm_v5t_le-gcc -v -DVERSION="\"3.2\"" -o sdpd *.c -lbluetooth

========================================================================
======

Please tell me what are the changes I should make while compiling and
installing lib and util packages, so that I could also able to attach
broadcom bluetooth board. Please excuse me, if I am asking something
obvious or still it is generic. I have found some files related named
related to broadcom in "extra" folder of the util package, some
declarations in acinclude.m4 file, but getting no idea how to use those
or modify those.

Thanks and Regards,
Deekshitulu.

-----Original Message-----
From: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Tuesday, September 11, 2007 12:35 AM
To: BlueZ users
Subject: Re: [Bluez-users] Bluez Stack compilation for broadcom board

Hi,

>  Please tell me what is the procedure to compile bluez source code for

> the broadcom bluetooth board, BCM2045.

you must ask specific question and not such generic ones. These kind of
questions will get you no help here since even I have no idea what you
actually wanna do.

Regards

Marcel



------------------------------------------------------------------------
-
This SF.net email is sponsored by: Microsoft Defy all challenges.
Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
