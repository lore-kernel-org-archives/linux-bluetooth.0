Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4818FD30-C986-47E0-8441-E58938077D45@holtmann.org>
References: <1386759341-14346-1-git-send-email-luiz.dentz@gmail.com>
	<4818FD30-C986-47E0-8441-E58938077D45@holtmann.org>
Date: Wed, 11 Dec 2013 14:55:32 +0200
Message-ID: <CABBYNZJnpr4ddFRvZakjQ6dhK+acxfteow52bO4GZo++M=M5dw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] build: Add coverage support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Dec 11, 2013 at 2:00 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Luiz,
>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> ---
>> Makefile.am         | 18 ++++++++++++++++++
>> acinclude.m4        |  9 +++++++++
>> bootstrap-configure |  1 +
>> configure.ac        |  2 ++
>> 4 files changed, 30 insertions(+)
>>
>> diff --git a/Makefile.am b/Makefile.am
>> index 15cc149..1a59532 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -331,5 +331,23 @@ lib/bluetooth/%.h: lib/%.h
>>       $(AM_V_at)$(MKDIR_P) lib/bluetooth
>>       $(AM_V_GEN)$(LN_S) -f "$(abs_top_builddir)"/$< $@
>>
>> +if COVERAGE
>
> maybe we should just make this depend on maintainer-mode.

We could, but I suggest you do a quick run with this version to see if
it is acceptable for maintainer-mode since it does increase quite a
bit the build time for me so perhaps we should keep it separately.

>> +clean-coverage:
>> +     $(RM) -r coverage
>> +     @find . -name "*.gcda" -exec $(RM) {} \;
>> +     $(LCOV) --directory . --zerocounters
>> +
>> +check-coverage:
>> +     @make check
>> +     $(AM_V_at)$(MKDIR_P) -p coverage
>> +     $(LCOV) --compat-libtool --directory . --capture --output-file \
>> +                                                     coverage/check.inf=
o
>> +     @genhtml -o coverage/ coverage/check.info
>> +
>> clean-local:
>> +     @make clean-coverage
>>       $(RM) -r lib/bluetooth
>> +else
>> +clean-local:
>> +     $(RM) -r lib/bluetooth
>> +endif
>> diff --git a/acinclude.m4 b/acinclude.m4
>> index 2065852..e5eb481 100644
>> --- a/acinclude.m4
>> +++ b/acinclude.m4
>> @@ -51,6 +51,15 @@ AC_DEFUN([MISC_FLAGS], [
>>                       misc_ldflags=3D"$misc_ldflags -pie"
>>               fi
>>       ])
>> +     AC_ARG_ENABLE(coverage, AC_HELP_STRING([--enable-coverage],
>> +                     [enable coverage flags]), [
>> +             AC_PATH_PROG([LCOV], [lcov])
>> +             if (test "$LCOV" && test "${enableval}" =3D "yes"); then
>> +                     misc_cflags=3D"$misc_cflags -ftest-coverage"
>> +                     misc_cflags=3D"$misc_cflags -fprofile-arcs"
>> +                     misc_ldflags=3D"$misc_ldflags -gcov"
>> +             fi
>> +     ])
>>       AC_SUBST([MISC_CFLAGS], $misc_cflags)
>>       AC_SUBST([MISC_LDFLAGS], $misc_ldflags)
>> ])
>> diff --git a/bootstrap-configure b/bootstrap-configure
>> index c7f08ed..35aa98b 100755
>> --- a/bootstrap-configure
>> +++ b/bootstrap-configure
>> @@ -14,4 +14,5 @@ fi
>>               --enable-experimental \
>>               --enable-android \
>>               --enable-sixaxis \
>> +             --enable-coverage \
>>               --disable-datafiles $*
>> diff --git a/configure.ac b/configure.ac
>> index 18d0b55..c55924f 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -252,4 +252,6 @@ AC_ARG_ENABLE(android, AC_HELP_STRING([--enable-andr=
oid],
>>                                       [enable_android=3D${enableval}])
>> AM_CONDITIONAL(ANDROID, test "${enable_android}" =3D "yes")
>>
>> +AM_CONDITIONAL([COVERAGE], [test "$LCOV=94])
>
> I do not like this one. The test should check enable_xxx variables. I rat=
her have configure abort with error if some programs or dependencies are no=
t found.

Okay, Ive named it LCOV because it actually checks for lcov binary and
then uses it in Makefile.am at check-coverage and clean-coverage, it
comes from AC_PATH_PROG([LCOV], [lcov]). I can do AC_MSG_ERROR if lcov
is not found, is that how you want it? I couldn't make AM_CONDITIONAL
within MISC_FLAGS that why Ive moved it to configure.ac.
--=20
Luiz Augusto von Dentz
