Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <52400F2B.9010501@linux.intel.com>
References: <1379679871-29623-1-git-send-email-frederic.danis@linux.intel.com>
	<226042C8-264A-469E-8D6A-F41141DC0552@holtmann.org>
	<52400F2B.9010501@linux.intel.com>
Date: Mon, 23 Sep 2013 21:26:27 +0200
Message-ID: <CAN_7+YbCJGqBmT_UtdFXKsiLccuzUbCSv1aPdm3734aE4wHX1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] android: Add skeleton of BlueZ Android daemon
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=047d7b6721c418b9df04e711ff54
List-ID: <linux-bluetooth.vger.kernel.org>

--047d7b6721c418b9df04e711ff54
Content-Type: text/plain; charset=ISO-8859-1

Hi Marcel


On Mon, Sep 23, 2013 at 11:51 AM, Frederic Danis <
frederic.danis@linux.intel.com> wrote:

> Hello Marcel,
>
> On 21/09/2013 19:14, Marcel Holtmann wrote:
>
>> Hi Fred,
>>
>>  Define local mapping to glib path, otherwise this has to be inside
>>> central
>>> place in the build repository.
>>>
>>> Retrieve Bluetooth version from configure.ac.
>>> ---
>>> .gitignore         |    2 +
>>> Android.mk         |    9 ++++
>>> Makefile.am        |    1 +
>>> Makefile.android   |    7 ++++
>>> android/Android.mk |   24 +++++++++++
>>> android/main.c     |  119 ++++++++++++++++++++++++++++++**
>>> ++++++++++++++++++++++
>>> configure.ac       |    5 +++
>>> 7 files changed, 167 insertions(+)
>>> create mode 100644 Android.mk
>>> create mode 100644 Makefile.android
>>> create mode 100644 android/Android.mk
>>> create mode 100644 android/main.c
>>>
>>
>> lets split this out a little bit. Code additions should not be intermixed
>> with additions to the build system and especially configure options.
>>
>> I rather not have a top-level Android.mk. It should be enough to provide
>> an android/Android.mk.
>>
>> BTW, do you expect to have only one Android.mk for the whole project or
this is OK for you to have smaller Android.mk in different subfolders like
/src/shared etc. Both ways are valid.

BR
Lukasz

--047d7b6721c418b9df04e711ff54
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra">Hi Marcel<br><br><br><div c=
lass=3D"gmail_quote">On Mon, Sep 23, 2013 at 11:51 AM, Frederic Danis <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:frederic.danis@linux.intel.com" target=
=3D"_blank">frederic.danis@linux.intel.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">Hello Marcel,<br>
<br>
On 21/09/2013 19:14, Marcel Holtmann wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
Hi Fred,<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
Define local mapping to glib path, otherwise this has to be inside central<=
br>
place in the build repository.<br>
<br>
Retrieve Bluetooth version from <a href=3D"http://configure.ac" target=3D"_=
blank">configure.ac</a>.<br>
---<br>
.gitignore =A0 =A0 =A0 =A0 | =A0 =A02 +<br>
Android.mk =A0 =A0 =A0 =A0 | =A0 =A09 ++++<br>
Makefile.am =A0 =A0 =A0 =A0| =A0 =A01 +<br>
Makefile.android =A0 | =A0 =A07 ++++<br>
android/Android.mk | =A0 24 +++++++++++<br>
android/main.c =A0 =A0 | =A0119 ++++++++++++++++++++++++++++++<u></u>++++++=
++++++++++++++++<br>
<a href=3D"http://configure.ac" target=3D"_blank">configure.ac</a> =A0 =A0 =
=A0 | =A0 =A05 +++<br>
7 files changed, 167 insertions(+)<br>
create mode 100644 Android.mk<br>
create mode 100644 Makefile.android<br>
create mode 100644 android/Android.mk<br>
create mode 100644 android/main.c<br>
</blockquote>
<br>
lets split this out a little bit. Code additions should not be intermixed w=
ith additions to the build system and especially configure options.<br>
<br>
I rather not have a top-level Android.mk. It should be enough to provide an=
 android/Android.mk.<br>
<br></blockquote></blockquote><div>BTW, do you expect to have only one Andr=
oid.mk for the whole project or this is OK for you to have smaller Android.=
mk in different subfolders like /src/shared etc. Both ways are valid.=A0</d=
iv>
<div><br></div></div>BR<br>Lukasz</div></div>

--047d7b6721c418b9df04e711ff54--
