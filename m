Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <1086538596.40c34364bec57@webmail.rnl.ist.utl.pt>
From: dsas@mega.ist.utl.pt
To: bluez-devel@lists.sourceforge.net
References: <1086088581.40bc65850efcf@webmail.rnl.ist.utl.pt>  <1086094054.1978.26.camel@fischer>  <1086102474.40bc9bca939eb@webmail.rnl.ist.utl.pt>  <1086536804.40c33c64e8456@webmail.rnl.ist.utl.pt> <1086537556.4765.59.camel@pegasus>
In-Reply-To: <1086537556.4765.59.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Re: Problems while sending and receiving with rfcomm sockects
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun,  6 Jun 2004 17:16:36 +0100

Hi Marcel,

No, I don't use hcidump. I simply compare the array of chars passed in se=
nd()
with the one I receive with recv().

Regards,

Didier

> > Just one more thing about this: The number of bytes sent and received=
 is
> > the same but the data received appears shifted by one byte... Strange=
.
>
> How do you compare this? You don't use hcidump for it, do you? All
> version prior 1.8 don't decode the credit based flow control byte
> correctly. They show it as part of the payload.





-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
