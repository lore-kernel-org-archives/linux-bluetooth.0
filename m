Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20060119120727.60487.qmail@web8404.mail.in.yahoo.com>
From: shankar marrapu <hifrom122@yahoo.co.in>
To: JABWT@yahoogroups.com
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1622107141-1137672447=:56551"
Subject: [Bluez-users] Need HELP  in JavaBluetooth API
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
Date: Thu, 19 Jan 2006 12:07:27 +0000 (GMT)

--0-1622107141-1137672447=:56551
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hai
             I am implementing Bluetooth stack(inindows XP Using javaBluetooth API(jsr-82)  as part of final year project.i face following errors while executing demo programs which are in your JavaBluetooth API(JSR-82).
  
              Is there any package related to javax.comm to execute  Bluetooth in
  Windows environment?
  
1. this error occur while executing BluetoothBrowser.java
  Error:
       
       Exception in thread "main" org.javabluetooth.stack.hci.HCIException:      HCIManagerR
      emoteClient: IOException: java.net.ConnectException: Connection refused: connect
          at org.javabluetooth.distributed.BluetoothTCPClient.<init>(BluetoothTCPC
        lient.java:82)
        at org.javabluetooth.demo.gui.BluetoothBrowser.main(BluetoothBrowser.jav
       a:162)
        Press any key to continue...   
   
   
  2. this error occur while executing BluetoothServer.java
  
Error:
         Exception in thread "main" java.lang.Error: Unresolved compilation problems:
        The import javax.comm cannot be resolved
        The import javax.comm cannot be resolved
        The import javax.comm cannot be resolved
        The import javax.comm cannot be resolved
        The import javax.comm cannot be resolved
        The import javax.comm cannot be resolved
        The import javax.comm cannot be resolved
        SerialPortEventListener cannot be resolved or is not a valid superinterf
        ace
        CommPortIdentifier cannot be resolved or is not a type
        CommPortIdentifier cannot be resolved
        CommPortIdentifier cannot be resolved
        SerialPort cannot be resolved or is not a type
        SerialPort cannot be resolved
        SerialPort cannot be resolved
        SerialPort cannot be resolved
        NoSuchPortException cannot be resolved or is not a type
        SerialPortEvent cannot be resolved (or is not a valid type) for the argu
         ment event of the method serialEvent
          at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)
          at sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstruct
        orAccessorImpl.java:39)
        at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingC
         onstructorAccessorImpl.java:27)
        at java.lang.reflect.Constructor.newInstance(Constructor.java:494)
        at org.javabluetooth.stack.hci.UARTTransport.<init>(UARTTransport.java:2
        5)
        at org.javabluetooth.demo.BluetoothServer.main(BluetoothServer.java:28)
        Press any key to continue...  
        
   
                                 Please help me as soon as possible.
   
       
   
   M.U.Gowri shankar,

Send instant messages to your online friends http://in.messenger.yahoo.com 
--0-1622107141-1137672447=:56551
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>Hai</DIV>  <DIV>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I am implementing Bluetooth stack(inindows XP Using javaBluetooth API(jsr-82)&nbsp;&nbsp;as part of final year project.i face following errors while executing demo programs which are in your JavaBluetooth API(JSR-82).<BR>&nbsp; <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Is there any package related to javax.comm to execute&nbsp; Bluetooth in<BR>&nbsp; Windows environment?</DIV>  <DIV><BR>1. this error occur while executing BluetoothBrowser.java</DIV>  <DIV>Error:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;Exception in thread "main" org.javabluetooth.stack.hci.HCIException:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCIManagerR<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; emoteClient: IOException: java.net.ConnectException: Connection refused: connect</DIV>  <DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; at
 org.javabluetooth.distributed.BluetoothTCPClient.&lt;init&gt;(BluetoothTCPC<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lient.java:82)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; at org.javabluetooth.demo.gui.BluetoothBrowser.main(BluetoothBrowser.jav<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a:162)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Press any key to continue...&nbsp;&nbsp; </DIV>  <DIV>&nbsp;</DIV>  <DIV>&nbsp;</DIV>  <DIV>2. this error occur while executing BluetoothServer.java</DIV>  <DIV><BR>Error:</DIV>  <DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Exception in thread "main" java.lang.Error: Unresolved compilation problems:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The import javax.comm cannot be resolved<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The import javax.comm cannot be resolved<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The import javax.comm cannot be resolved<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The import javax.comm cannot be
 resolved<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The import javax.comm cannot be resolved<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The import javax.comm cannot be resolved<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The import javax.comm cannot be resolved<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SerialPortEventListener cannot be resolved or is not a valid superinterf<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ace<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CommPortIdentifier cannot be resolved or is not a type<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CommPortIdentifier cannot be resolved<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CommPortIdentifier cannot be resolved<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SerialPort cannot be resolved or is not a type<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SerialPort cannot be resolved<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SerialPort cannot be
 resolved<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SerialPort cannot be resolved<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NoSuchPortException cannot be resolved or is not a type<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SerialPortEvent cannot be resolved (or is not a valid type) for the argu<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ment event of the method serialEvent</DIV>  <DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)</DIV>  <DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; at sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstruct<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; orAccessorImpl.java:39)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingC<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; onstructorAccessorImpl.java:27)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; at
 java.lang.reflect.Constructor.newInstance(Constructor.java:494)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; at org.javabluetooth.stack.hci.UARTTransport.&lt;init&gt;(UARTTransport.java:2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; at org.javabluetooth.demo.BluetoothServer.main(BluetoothServer.java:28)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Press any key to continue...&nbsp; </DIV>  <DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </DIV>  <DIV>&nbsp;</DIV>  <DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Please help me as soon as possible.</DIV>  <DIV>&nbsp;</DIV>  <DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV>  <DIV>&nbsp;</DIV>  <DIV>&nbsp;M.U.Gowri shankar,</DIV><p>Send instant messages to your online friends http://in.messenger.yahoo.com 
--0-1622107141-1137672447=:56551--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
