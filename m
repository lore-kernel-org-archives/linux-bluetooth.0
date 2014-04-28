Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLD0U=JwUPCNT2pHgeEo+fVqKsAMsPJepQXOQEwp=YzRw@mail.gmail.com>
References: <1387372162-7096-1-git-send-email-luiz.dentz@gmail.com>
	<CABBYNZ+zw_yuUbp1GvMVkOVDQUr_4Xup+SUy4nhj=kb_QaKXUg@mail.gmail.com>
	<C2EB6265-CEEC-4D1A-8A11-42D0AC64B290@holtmann.org>
	<CABBYNZLD0U=JwUPCNT2pHgeEo+fVqKsAMsPJepQXOQEwp=YzRw@mail.gmail.com>
Date: Mon, 28 Apr 2014 11:34:47 +0300
Message-ID: <CABBYNZLwanKu3NSi0svNrNA3ZQqtQJAT7h6ZK-UFvktyi1z8mA@mail.gmail.com>
Subject: Re: [PATCH v2 BlueZ] build: Add coverage support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Dec 23, 2013 at 4:20 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Marcel,
>
> On Mon, Dec 23, 2013 at 3:57 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Hi Luiz,
>>
>>>> Coverage is enabled with --enable-maintainer-mode, 2 new targets are
>>>> added 'coverage' and 'clean-coverage', the first generate the reports
>>>> using lcov and depend on the second to cleanup previous generated
>>>> reports and .gcda files.
>>>> ---
>>>> .gitignore   |  4 ++++
>>>> Makefile.am  | 18 ++++++++++++++++++
>>>> acinclude.m4 |  4 ++++
>>>> configure.ac |  4 ++++
>>>> 4 files changed, 30 insertions(+)
>>>>
>>>> diff --git a/.gitignore b/.gitignore
>>>> index c570728..21dbe26 100644
>>>> --- a/.gitignore
>>>> +++ b/.gitignore
>>>> @@ -3,6 +3,8 @@
>>>> *.lo
>>>> *.la
>>>> *.so
>>>> +*.gcno
>>>> +*.gcda
>>>> .deps
>>>> .libs
>>>> .dirstamp
>>>> @@ -27,7 +29,9 @@ stamp-h1
>>>> autom4te.cache
>>>> test-driver
>>>> test-suite.log
>>>> +coverage.info
>>>>
>>>> +coverage
>>>> lib/bluez.pc
>>>> lib/bluetooth
>>>> src/builtin.h
>>>> diff --git a/Makefile.am b/Makefile.am
>>>> index 15cc149..7380e61 100644
>>>> --- a/Makefile.am
>>>> +++ b/Makefile.am
>>>> @@ -331,5 +331,23 @@ lib/bluetooth/%.h: lib/%.h
>>>>        $(AM_V_at)$(MKDIR_P) lib/bluetooth
>>>>        $(AM_V_GEN)$(LN_S) -f "$(abs_top_builddir)"/$< $@
>>>>
>>>> +if MAINTAINER_MODE
>>>> +clean-coverage:
>>>> +       -find $(top_builddir) -name "*.gcda" -delete
>>>> +       @lcov --directory $(top_builddir) --zerocounters
>>>> +       $(RM) -r coverage $(top_builddir)/coverage.info
>>>> +
>>>> +coverage: clean-coverage check
>>>> +       @lcov --compat-libtool --directory $(top_builddir) --capture \
>>>> +                               --output-file $(top_builddir)/coverage.info
>>>> +       $(AM_V_at)$(MKDIR_P) coverage
>>>> +       @genhtml -o coverage/ $(top_builddir)/coverage.info
>>>> +
>>>> +clean-local: clean-coverage
>>>> +       -find $(top_builddir) -name "*.gcno" -delete
>>>> +       $(RM) -r lib/bluetooth
>>>> +
>>>> +else
>>>> clean-local:
>>>>        $(RM) -r lib/bluetooth
>>>> +endif
>>>> diff --git a/acinclude.m4 b/acinclude.m4
>>>> index 2065852..afc7c6d 100644
>>>> --- a/acinclude.m4
>>>> +++ b/acinclude.m4
>>>> @@ -51,6 +51,10 @@ AC_DEFUN([MISC_FLAGS], [
>>>>                        misc_ldflags="$misc_ldflags -pie"
>>>>                fi
>>>>        ])
>>>> +       if (test "$USE_MAINTAINER_MODE" = "yes"); then
>>>> +               misc_cflags="$misc_cflags --coverage"
>>>> +               misc_ldflags="$misc_ldflags --coverage"
>>>> +       fi
>>>>        AC_SUBST([MISC_CFLAGS], $misc_cflags)
>>>>        AC_SUBST([MISC_LDFLAGS], $misc_ldflags)
>>>> ])
>>>> diff --git a/configure.ac b/configure.ac
>>>> index 18d0b55..4f36355 100644
>>>> --- a/configure.ac
>>>> +++ b/configure.ac
>>>> @@ -252,4 +252,8 @@ AC_ARG_ENABLE(android, AC_HELP_STRING([--enable-android],
>>>>                                        [enable_android=${enableval}])
>>>> AM_CONDITIONAL(ANDROID, test "${enable_android}" = "yes")
>>>>
>>>> +if (test "$USE_MAINTAINER_MODE" = "yes"); then
>>>> +       AC_CHECK_PROG([LCOV], [lcov], [yes], AC_MSG_ERROR(lcov is required))
>>>> +fi
>>>> +
>>>> AC_OUTPUT(Makefile src/bluetoothd.8 lib/bluez.pc)
>>>> --
>>>> 1.8.3.1
>>>
>>> Any feedback regarding this patch? It is now using maintainer mode as
>>> you suggested.
>>
>> I have not tested it yet. In general this looks just fine. However the if else with clean-local in each branches is still something that I think could be done a bit cleaner.
>
> Im all for it as well, but note that the .gcna needs to be cleanup
> manually since they are not created by the build itself but at runtime
> when the binary is run thus why I made clean-local to depend on
> clean-coverage , the .gcno files could be cleanup like any .o file but
> I couldn't figure out how to do it so far.

Revisiting this one, the other way some projects are cleaning .gcno
.gcna is adding those to CLEANFILES (e.g. CLEANFILES += *.gcno
*.gcda), but in this case we have to every sub-directory so it might
be more troublesome to maintain.

Another thing we could check is if this may actually be done
automatically by autotools in future since apparently it does cleanup
some files generated such as *.o it could cleanup *.gcno.


-- 
Luiz Augusto von Dentz
