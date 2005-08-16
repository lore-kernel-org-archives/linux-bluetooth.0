Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05081614151ee4f4bd@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] bluetoothd D-Bus interface proposals(draft 00.05)
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
Date: Tue, 16 Aug 2005 18:15:37 -0300

Hi folks,

I am posting a new draft of D-Bus architecture and Interfaces.=20

If someone has comments regarding the design, interfaces or any kind
of question send us a feedback.

This last draft contains some changes based on Johan Hedberg feedback
and new services.

Major changes:
* Return "D-Bus error messages" instead of "method return" following
the Johan Hedberg suggestion
* Defined standard error messages
* Added "architecture" overview section.
* Using just one interface for request and signals instead of distinct
interfaces. The message type can be discovered using the message type
attribute embedded in the D-Bus message header.

Location:
The document (draft 00.05) can be found at: http://www.cin.ufpe.br/~ckt/blu=
ez

Next action:
* define SDP D-Bus services and architecture.
* Multi-level disconnection/connection signals. Is it really
necessary? eg: send disconnect signal at pan and hci D-Bus interfaces.
* Signal level. Is it possible check it? IS it really necessary?
* Unify rfcomm and dun D-Bus services. Is it feasible?


Suggestions a welcome!

Regards,
Claudio


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
