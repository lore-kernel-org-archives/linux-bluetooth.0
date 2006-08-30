Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 30 Aug 2006 12:51:25 -0700
From: David Armour <d.f.armour@shaw.ca>
To: bluez-users@lists.sourceforge.net
Message-id: <44F5EC3D.1050607@shaw.ca>
MIME-version: 1.0
Subject: [Bluez-users] bash: syntax error near unexpected token `newline'
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

hello list,

i hope this is the right place to ask for help translating the above 
error. googling the error message produced no hits.

i'm trying to get my plantronics headset working with Micro Star 
International Bluetooth Dongle. i've gotten further using info found at:

http://article.gmane.org/gmane.linux.ubuntu.user/77096/match=bluez+gnome+headset+dapper 


than with anything i could dig up in the wiki, or in the ubuntu forums.

## for plantronics headset, the red&blue lights must be flashing  ## check!
 >> The command should output something like this:
 >> Scanning ...     00:13:70:4F:83:3B       Nokia HS-26W
## for headset,...    00:03:89:53:EC:7F       320 Plantronics    ## woohoo!
 >>
 >> The set of numbers is the Bluetooth Device Address, bd_addr for short.
 >> Running the command: >> sudo hidd --connect <bd_addr>
 >> should connect the mouse to the computer, and allow the mouse to work.

## running: >>sudo hidd --connect <00:03:89:53:EC:7F>
## bash: syntax error near unexpected token `newline'        ## gah!

can someone where to look to address this error? thanks in advance.

## relevant hcid.conf:  (tried both pinwrapper/bluepin lines 
with/without ';')

# HCId options
options {
    # Automatically initialize new devices
    autoinit yes;

    # Security Manager mode
    #   none - Security manager disabled
    #   auto - Use local PIN for incoming connections
    #   user - Always ask user for a PIN
    #
    security auto;

    # Pairing mode
    #   none  - Pairing disabled
    #   multi - Allow pairing with already paired devices
    #   once  - Pair once and deny successive attempts
    pairing multi;

    # PIN helper
    #pin_helper /usr/bin/pinwrapper;
    pin_helper /usr/bin/bluepin;

    # D-Bus PIN helper
    #dbus_pin_helper;
}


 >> hcidump -X -V
 >> bash: hcidump: command not found         ## ????


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
