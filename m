Return-Path: <cyrus@holtmann.org>
Message-ID: <70c1792a0804241205s17ef0f61wbe29cb9d8fc2cfff@mail.gmail.com>
Date: Thu, 24 Apr 2008 12:05:40 -0700
From: "Fredrick Smithson" <fredricksmithson@gmail.com>
To: bluez-users@lists.sourceforge.net,
	bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Qualification of products based on bluez
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
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
List-ID: <bluez-devel.lists.sourceforge.net>

Hi,

I am looking for some advice on Bluetooth qualification of products
based on bluez.
I notice that bluez is already Bluetooth certified:

http://www.bluez.org/qualification.html

On bluetooth.org I see 4 certifications,

PRD 2.0  	  B013645   	BlueZ Protocol Stack  	  BlueZ   	 Samsung
Electronics Co., Ltd.  	Component (Tested)  	07-Jan-2008
PRD 2.0 	B013444 	BlueZ Host Stack 	BlueZ Host Stack 	Nokia
Corporation 	Host Subsystem 	08-Nov-2007
PRD 2.0 	B010348 	BlueZ Protocol Stack 	TomTom GO 	TomTom 	Host
Subsystem 	21-Dec-2006 	QPID:B0214400
PRD 1.0 	B0214400 	BlueZ Protocol Stack 	BlueZ 	Tom Tom BV 	Subsystem
	11-Apr-2005 	QDID:B010348

I am wondering if new Bluetooth products based on bluez need to
certify the bluez subsystem stack again, or if we can use the existing
certifications and just certify our BT profiles that exist above the
bluez GAP/RFCOMM/SDP stack. If we can use existing certifications,
which one is most appropriate.

I ask this question since we are not affiliated with any of the
company's with existing bluez certifications, so I am not sure if we
can use there certifications.

I think this is an important question for company's considering using
bluez to develop new products, and any advice would be appreciated. I
have heard it can take months to qualify the subsystem stack, it would
be great if we can use the existing qualifications.

Regards,
Nick

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
