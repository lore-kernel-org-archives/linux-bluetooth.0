Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: sanjeevi <sanjayvenugopal@hotmail.com>
Message-ID: <loom.20060222T124423-716@post.gmane.org>
References: <20060119120727.60487.qmail@web8404.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [Bluez-users] Re: Need HELP  in JavaBluetooth API
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
Date: Wed, 22 Feb 2006 11:59:45 +0000 (UTC)

shankar marrapu <hifrom122 <at> yahoo.co.in> writes:

> 
> 
> Hai             I am implementing Bluetooth stack(inindows XP Using 
javaBluetooth API(jsr-82)  as part of final year project.i face following 
errors while executing demo programs which are in your JavaBluetooth API(JSR-
82).                Is there any package related to javax.comm to execute  
Bluetooth in  Windows environment?  
> 1. this error occur while executing BluetoothBrowser.java  
Error:              Exception in thread "main" 
org.javabluetooth.stack.hci.HCIException:      HCIManagerR      emoteClient: 
IOException: java.net.ConnectException: Connection refused: connect          at
>  org.javabluetooth.distributed.BluetoothTCPClient.<init>(BluetoothTCPC        
lient.java:82)        at org.javabluetooth.demo.gui.BluetoothBrowser.main
(BluetoothBrowser.jav       a:162)        Press any key to 
continue...           2. this error occur while executing BluetoothServer.java  
> Error:         Exception in thread "main" java.lang.Error: Unresolved 
compilation problems:        The import javax.comm cannot be resolved        
The import javax.comm cannot be resolved        The import javax.comm cannot be 
resolved        The import javax.comm cannot be
>  resolved        The import javax.comm cannot be resolved        The import 
javax.comm cannot be resolved        The import javax.comm cannot be 
resolved        SerialPortEventListener cannot be resolved or is not a valid 
superinterf        ace        CommPortIdentifier cannot be resolved or is not a 
type        CommPortIdentifier cannot be resolved        CommPortIdentifier 
cannot be resolved        SerialPort cannot be resolved or is not a type        
SerialPort cannot be resolved        SerialPort cannot be
>  resolved        SerialPort cannot be resolved        NoSuchPortException 
cannot be resolved or is not a type        SerialPortEvent cannot be resolved 
(or is not a valid type) for the argu         ment event of the method 
serialEvent          at sun.reflect.NativeConstructorAccessorImpl.newInstance0
(Native Method)          at 
sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstruct        
orAccessorImpl.java:39)        at 
sun.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingC         
onstructorAccessorImpl.java:27)        at
>  java.lang.reflect.Constructor.newInstance(Constructor.java:494)        at 
org.javabluetooth.stack.hci.UARTTransport.<init>(UARTTransport.java:2        
5)        at org.javabluetooth.demo.BluetoothServer.main
(BluetoothServer.java:28)        Press any key to 
continue...                                              Please help me as soon 
as possible.                M.U.Gowri shankar,
> Send instant messages to your online friends http://in.messenger.yahoo.com 
> 


hai shankar,
i am sanjeevi sanjayvenugopal@hotmail.com
i too have the same problem .
did you get any solutions .
i am doing final year project.
so please reply and help me.

thankyou,

regards,
sanjeevi.v








-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
