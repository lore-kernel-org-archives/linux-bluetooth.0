Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid patch (patch 00.13)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051010195850.GA23080@localhost.localdomain>
References: <e1effdeb0510060731s191b17bbrd52897af77622ba6@mail.gmail.com>
	 <1128784148.5212.17.camel@blade>
	 <e1effdeb0510081605p56bcd8fcob8fcd77f616c105d@mail.gmail.com>
	 <1128896442.19569.26.camel@blade>
	 <20051010195850.GA23080@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Message-Id: <1128977357.7352.1.camel@blade>
Mime-Version: 1.0
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
Date: Mon, 10 Oct 2005 22:49:17 +0200

Hi Johan,

> I took a closer look at the latest D-BUS patch and made a couple of
> fixes. A rather severe bug was that only 1 byte was allocated for the
> data pointer in the object path functions, but a uint16_t value was
> written to it. The attached patch removes the need to allocate this
> memory alltogether by typecasting the integer values directly to the
> void pointer (perhaps not a very "beautiful" solution, but it works and
> simplifies the code quite a lot). The patch also contains some general
> cleanup (removal of unecessary typecasts, etc).

I applied the patch, but this can't be the final solution. It will
produce weird stuff on 64-bit machines:

dbus.c: In function =E2=80=98add_watch=E2=80=99:
dbus.c:525: warning: cast to pointer from integer of different size
dbus.c: In function =E2=80=98remove_watch=E2=80=99:
dbus.c:532: warning: cast from pointer to integer of different size
dbus.c: In function =E2=80=98hci_dbus_reg_obj_path=E2=80=99:
dbus.c:731: warning: cast to pointer from integer of different size
dbus.c: In function =E2=80=98msg_func=E2=80=99:
dbus.c:829: warning: cast from pointer to integer of different size
dbus.c: In function =E2=80=98handle_periodic_inq_req=E2=80=99:
dbus.c:921: warning: cast from pointer to integer of different size
dbus.c: In function =E2=80=98handle_cancel_periodic_inq_req=E2=80=99:
dbus.c:1000: warning: cast from pointer to integer of different size
dbus.c: In function =E2=80=98handle_inq_req=E2=80=99:
dbus.c:1046: warning: cast from pointer to integer of different size
dbus.c: In function =E2=80=98handle_role_switch_req=E2=80=99:
dbus.c:1115: warning: cast from pointer to integer of different size

Patches to fix this are welcome.

> Then, about the signals sent for inquiry result and name request. You
> currently also send the local BT address in the message parameters.
> Isn't that redundant since the local device should be evident from the
> object path that the message originates from? I know that the path isn'=
t
> currently set properly for these signals, but in the future it probably
> should.

Please send in a patch to fix this.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
