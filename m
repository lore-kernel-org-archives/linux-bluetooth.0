Return-Path: <cyrus@holtmann.org>
From: <ext-jablonski.radoslaw@nokia.com>
To: <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>
Date: Wed, 7 Jul 2010 16:20:16 +0200
Subject: RE: [PATCH] Added empty VCARD N: parameter handling
Message-ID: <090FE800A758CA439B2752C082AC3DEF037828C921@NOK-EUMSG-06.mgdnok.nokia.com>
References: <090FE800A758CA439B2752C082AC3DEF037828C920@NOK-EUMSG-06.mgdnok.nokia.com>,<1278508613.2789.114.camel@localhost.localdomain>
In-Reply-To: <1278508613.2789.114.camel@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!
I've made necessary changes to the code. Now it should look much better:)
New version of patch is inserted below.

>From 45dfcf8f9dfacd8937a1a1d14146bd0da04eca25 Mon Sep 17 00:00:00 2001
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Date: Wed, 7 Jul 2010 17:18:31 +0300
Subject: [PATCH] Added empty VCARD N: parameter handling

Some of the devices are expecting that N: parameter in VCARD is always fill=
ed (by example Nokia BH-903)
When this field is empty (N:;;;;) then list of dialed/incoming calls on car=
kit is useless - carkit then shows only blank lines and it's impossible to =
determine who made call ( phone number are invisible too in this case)

If none of the contact fields is available, then setting telephone number a=
s the first attribute for "N:" parameter.
Carkit will see that number as contact name - it is only used in case when =
none of more detailed contact information is available on the phone.
---
 plugins/vcard.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index 5948a4a..ab1349c 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -123,6 +123,20 @@ static void add_slash(char *dest, const char *src, int=
 len_max, int len)
 	return;
 }
=20
+/* checks if there is at least one present contact field with personal dat=
a */
+static gboolean contact_fields_present( struct phonebook_contact * contact=
)
+{
+	if ((contact->family && strlen(contact->family)) ||
+			(contact->given && strlen(contact->given)) ||
+			(contact->additional && strlen(contact->additional)) ||
+			(contact->prefix && strlen(contact->prefix)) ||
+			(contact->suffix && strlen(contact->suffix)))
+		return TRUE;
+
+	/* none of the personal data fields is present*/
+	return FALSE;
+}
+
 static void vcard_printf_begin(GString *vcards, uint8_t format)
 {
 	vcard_printf(vcards, "BEGIN:VCARD");
@@ -136,6 +150,13 @@ static void vcard_printf_begin(GString *vcards, uint8_=
t format)
 static void vcard_printf_name(GString *vcards,
 					struct phonebook_contact *contact)
 {
+	if (contact_fields_present(contact) =3D=3D FALSE) {
+		/* if all fields are empty we're using first phone number as name */
+		struct phonebook_number *number =3D contact->numbers->data;
+		vcard_printf(vcards, "N:%s;;;;", number->tel);
+		return;
+	}
+
 	vcard_printf(vcards, "N:%s;%s;%s;%s;%s", contact->family,
 				contact->given, contact->additional,
 				contact->prefix, contact->suffix);
--=20
1.6.0.4


BR,
Radek
________________________________________
From: ext Marcel Holtmann [marcel@holtmann.org]
Sent: Wednesday, July 07, 2010 4:16 PM
To: Radoslaw Jablonski (EXT-Comarch/Helsinki)
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Added empty VCARD N: parameter handling

Hi Radek,

using git send-email would be a bit better here. Then we have the
patches inline.

> From 6d88e3d7c1a5014e60ca8f53f7163e3a51148530 Mon Sep 17 00:00:00 2001
> From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
> Date: Wed, 7 Jul 2010 15:07:58 +0300
> Subject: [PATCH] Added empty N: parameter handling in VCARD
>
> Some of the devices are expecting that N: parameter in VCARD is always fi=
lled (by example Nokia BH-903)
> When this field is empty (N:;;;;) then list of dialed/incoming calls on c=
arkit is useless.
>
> If none of fields is available then setting telephone number as the first=
 attribute for "N:" parameter.
> Carkit will see that number as contact name - it is only used in case whe=
n none of more detailed contact information is available on phone.
> ---
>  plugins/vcard.c |   17 ++++++++++++++---
>  1 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/plugins/vcard.c b/plugins/vcard.c
> index 5948a4a..b2ab30a 100644
> --- a/plugins/vcard.c
> +++ b/plugins/vcard.c
> @@ -136,9 +136,20 @@ static void vcard_printf_begin(GString *vcards, uint=
8_t format)
>  static void vcard_printf_name(GString *vcards,
>                                         struct phonebook_contact *contact=
)
>  {
> -       vcard_printf(vcards, "N:%s;%s;%s;%s;%s", contact->family,
> -                               contact->given, contact->additional,
> -                               contact->prefix, contact->suffix);
> +       /* at least one of fields is present */
> +       if ((contact->family && strlen(contact->family)) ||
> +               (contact->given && strlen (contact->given)) ||
> +               (contact->additional && strlen(contact->additional)) ||
> +               (contact->prefix && strlen (contact->prefix)) ||
> +               (contact->suffix && strlen (contact->suffix)))
> +               vcard_printf(vcards, "N:%s;%s;%s;%s;%s", contact->family,
> +                                               contact->given, contact->=
additional,
> +                                               contact->prefix, contact-=
>suffix);

The extra if clauses require two level of indentation. Otherwise you
can't tell which is part of the if clause and which is code.

Also it is strlen(...). No extra space.

And I would prefer to split this into an extra function just doing this
test. This if clause is too big.

> +       else {
> +               /* if all fields are empty we're using  first phone numbe=
r as name */
> +               struct phonebook_number *number =3D contact->numbers->dat=
a;
> +               vcard_printf(vcards, "N:%s;;;;", number->tel);
> +       }
>  }

So I prefer the whole thing like this:

        /* if all fields are empty we're using  first phone number as name =
*/
        if (required_fields_present(contact) =3D=3D FALSE) {
                struct phonebook_number *number =3D contact->numbers->data;
                vcard_printf(vcards, "N:%s;;;;", number->tel);
                return;
        }

        vcard_printf(vcards, "N:%s;%s;%s;%s;%s", contact->family,
                ...

This way it is a lot easier to read and understand what is the special
case and what would be the default.

Regards

Marcel
