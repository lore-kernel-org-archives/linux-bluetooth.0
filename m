Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Jul 2012 09:08:54 -0500
From: Bruce Hill <bruce@happypenguincomputers.com>
To: linux-bluetooth@vger.kernel.org
Subject: bt mouse won't reconnect
Message-ID: <20120716140854.GL18690@server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If this bt mouse is disconnected it will not connect again. This problem has                                                                                                                                                    
persisted from bluez-4.98 through 4.101. Presently 4.101 installed with                                                                                                                                                         
test-programs and usb. The mouse was working with 4.101 until booting into                                                                                                                                                      
kernel 3.5-rc1. It did not work in that kernel. Once booted back into                                                                                                                                                           
3.0.35-tuxonice it will not pair.                                                                                                                                                                                               
                                                                                                                                                                                                                                
laptop ~ # uname -a                                                                                                                                                                                                             
Linux laptop 3.0.35-tuxonice #1 SMP PREEMPT Mon Jul 2 12:03:49 CDT 2012 x86_64 Intel(R) Core(TM) i5-2520M CPU @ 2.50GHz GenuineIntel GNU/Linux                                                                                  
                                                                                                                                                                                                                                
laptop ~ # hcitool scan                                                                                                                                                                                                         
Scanning ...                                                                                                                                                                                                                    
        00:1F:20:1D:1B:4B       Bluetooth Laser Travel Mouse                                                                                                                                                                    
laptop ~ # simple-agent hci0 00:1F:20:1D:1B:4B                                                                                                                                                                                  
Creating device failed: org.bluez.Error.AlreadyExists: Already Exists                                                                                                                                                           
laptop ~ # bluez-test-device trusted 00:1F:20:1D:1B:4B yes                                                                                                                                                                      
laptop ~ # bluez-test-input connect 00:1F:20:1D:1B:4B                                                                                                                                                                           
Traceback (most recent call last):                                                                                                                                                                                              
  File "/usr/bin/bluez-test-input", line 42, in <module>                                                                                                                                                                        
    input.Connect()                                                                                                                                                                                                             
  File "/usr/lib64/python2.7/site-packages/dbus/proxies.py", line 70, in __call__                                                                                                                                               
    return self._proxy_method(*args, **keywords)                                                                                                                                                                                
  File "/usr/lib64/python2.7/site-packages/dbus/proxies.py", line 145, in __call__                                                                                                                                              
    **keywords)                                                                                                                                                                                                                 
  File "/usr/lib64/python2.7/site-packages/dbus/connection.py", line 651, in call_blocking                                                                                                                                      
    message, timeout)                                                                                                                                                                                                           
dbus.exceptions.DBusException: org.freedesktop.DBus.Error.NoReply: Did not receive a reply. Possible causes include: the remote application did not send a reply, the message bus                                               
+security policy blocked the reply, the reply timeout expired, or the network connection was broken.                                                                                                                            
                                                                                                                                                                                                                                
And hcitool cc <device> just returns to a prompt:                                                                                                                                                                               
                                                                                                                                                                                                                                
laptop ~ # hcitool scan                                                                                                                                                                                                         
Scanning ...                                                                                                                                                                                                                    
        00:1F:20:1D:1B:4B       Bluetooth Laser Travel Mouse                                                                                                                                                                    
laptop ~ # hcitool cc 00:1F:20:1D:1B:4B                                                                                                                                                                                         
laptop ~ #                                                                                                                                                                                                                      
                                                                                                                                                                                                                                
laptop ~ # lsusb | grep Blue                                                                                                                                                                                                    
Bus 001 Device 005: ID 0a5c:217f Broadcom Corp. Bluetooth Controller                                                                                                                                                            
                                                                                                                                                                                                                                
Relative kernel options:                                                                                                                                                                                                        
CONFIG_RFKILL=y                                                                                                                                                                                                                 
CONFIG_RFKILL_LEDS=y                                                                                                                                                                                                            
CONFIG_RFKILL_INPUT=y                                                                                                                                                                                                           
# CONFIG_TOSHIBA_BT_RFKILL is not set                                                                                                                                                                                           
CONFIG_BT=y                                                                                                                                                                                                                     
CONFIG_BT_L2CAP=y                                                                                                                                                                                                               
# CONFIG_BT_SCO is not set                                                                                                                                                                                                      
CONFIG_BT_RFCOMM=y                                                                                                                                                                                                              
# CONFIG_BT_RFCOMM_TTY is not set                                                                                                                                                                                               
CONFIG_BT_BNEP=y                                                                                                                                                                         
# CONFIG_BT_BNEP_MC_FILTER is not set  
# CONFIG_BT_BNEP_PROTO_FILTER is not set                                                                                                                                                                                        
CONFIG_BT_HIDP=y                                                                                                                                                                                                                
CONFIG_BT_HCIBTUSB=y

What are the proper commands to get this mouse paired again?
-- 
Happy Penguin Computers               >')
126 Fenco Drive                       ( \
Tupelo, MS 38801                       ^^
support@happypenguincomputers.com
662-269-2706 662-205-6424
http://happypenguincomputers.com/

Don't top-post: http://en.wikipedia.org/wiki/Top_post#Top-posting
