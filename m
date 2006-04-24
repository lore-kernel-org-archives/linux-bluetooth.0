Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <fe0a97c20604232227s383e43aet4144a8a9ea36149f@mail.gmail.com>
From: "Sowmya Gattupalli" <sowmya.gattupalli@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] SCOtest failed....
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
Date: Mon, 24 Apr 2006 01:27:57 -0400

Hi all
I have been using scotest for a while.... between my CSR and ISSC
dongles... it worked fine until yesterday....

M/c - A
root@bluetooth:~/bluez-utils-2.10/test# ./scotest -s 00:09:DD:10:00:CC
scotest[9095]: Can't connect. Function not implemented(38)
scotest[9095]: Can't connect to the server. Function not implemented(38)
root@bluetooth:~/bluez-utils-2.10/test#


M/c - B
root@bluetooth:~/bluez-utils-2.10/test# ./scotest -r
scotest[9092]: Waiting for connection ...



ne ideas... the SCO module is loaded.... what might be the reason for
this sudden error....??

Please help


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
