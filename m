Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41AC40DE.8030706@prim-time.fr>
From: Xavier Garreau <x.garreau@prim-time.fr>
MIME-Version: 1.0
To: "bluez-devel@lists.sourceforge.net" <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] sdp libs
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
Date: Tue, 30 Nov 2004 10:43:58 +0100

Hi,

Here's what I've got some more questions and remarks about sdplibs ...

First, i tried to use libuuid to parse a uuid encoded as a string but 
uuid_t from libuuid and uuid_t from sdplibs conflict. Maybe sdp uuid_t 
type should be renamed to sdp_uuid_t ?

If not, it could be great to add a function to sdp libs to parse an 
128bits uuid string to a uuid_t or uint8_t* (i.e. adding arguments to an 
drenaming the existing sdp_create_base_uuid, sdp_create_base_uuid could 
then call this generic function).

I also would like to be sure to have understood the meaning of the 
encapsulation of lists used for the protocol list attribute in sdp records.
We first have a list of choices for accessing the service
This list contains a list for each choice
This second level list contains a list for each protocol used for this 
particular choice.
This third level list contains uuid of the protocol and parameters 
related to the protocol.

For a service accesible both at RFCOMM and L2CAP levels (say on channel 
3 if RFCOMM is used or PSM 4433 if L2CAP is used), we would have:
- List1 : Protocols list (1st level list)
   - Choice 1 (2nd level List)
	- Protocol 1 (3rd level List)
		- L2cap UUID
		- PSM used: 4433
   - Choice 2  (2nd level List)
	- Protocol 1  (3rd level List)
		- Rfcomm UUID
		- Channel used: 3

List1 is used as the second param to sdp_set_access_protos.
Is this right ?

I also noticed that the sdp api in libs2 seems to be easier to use ?

Thank you for commenting what need to be.

Regards,
-- 
Xavier Garreau


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
