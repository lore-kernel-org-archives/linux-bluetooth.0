Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0510270733q23c9cf01u9b3a597d1adbe258@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [D-BUS PATCH] Authentication
In-Reply-To: <1130373447.32634.8.camel@blade>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb0510201045w5ebf17afh87897564184ce9f9@mail.gmail.com>
	 <1129986496.11428.36.camel@blade>
	 <e1effdeb0510240606l1998f61dhc2fe813c48b1e6db@mail.gmail.com>
	 <1130159970.19317.28.camel@blade>
	 <e1effdeb0510251203i7cb20240ua03a7f9aff38917d@mail.gmail.com>
	 <1130373447.32634.8.camel@blade>
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
Date: Thu, 27 Oct 2005 12:33:27 -0200

Hi Marcel,

Here are the patches based on the lastest BlueZ CVS. I am sending both
approaches.
Using signals is more clear in hcid side, however the clients will
have to add flags to indicate that there is a authentication pending.
Another problem is the error, using signals will not be possible send
D-Bus error messages, therefore client will have to translate the
status to a success or errors result.

I understand that store atributes to create a reply later is not a
clean solution but I don't see another solution. Using a peer message
it's possible reply errors properly and it easier develop the python/c
clients

I think it's better ask py-dbus developers about this. I prefer the
peer message reply approach.

Regards,
Claudio

PS: This is the message content for both approachs:
* Signal approach
  >>> D-Bus AuthenticationComplete signal
  - String: peer bt address
  - Byte: status
  - Uint16: handle

* For method return approach
   >>> D-Bus method return msg
   - String: peer bt address
   - Byte: handle
  >>> D-Bus error msg
   - String: error description
   - uint32: error code

On 10/26/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > Here are the patches to send the authentication result, please DON'T
> > commit it. Probably
> > it will conflict with the latest Eduardo's patch.
> >
> > Which approach do you preffer?
> > 1. Send a  signal
> > 2. Send a method return (peer message)
>
> I think that a signal to inform the applications that a connection is
> now authenticated (and also encrypted) is a good idea.
>
> Eduardos patches are now in the CVS. So you can re-create yours.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.
> Get Certified Today * Register for a JBoss Training Course
> Free Certification Exam for All Training Attendees Through End of 2005
> Visit http://www.jboss.com/services/certification for more information
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
