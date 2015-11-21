Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Michal Suchanek <hramrach@gmail.com>
Date: Sat, 21 Nov 2015 23:45:20 +0100
Message-ID: <CAOMqctQvwYLYp2N=sp+NHrAJyW9_8h6V1_KG-9cV5=uvBTzdSg@mail.gmail.com>
Subject: bluetoothd crashes when media endpoint SelectConfiguration reply does
 not contain an array
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=001a11441f10873158052514c1ae
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--001a11441f10873158052514c1ae
Content-Type: text/plain; charset=UTF-8

Hello,

I am using bluez 5.36 on Debian.

I tried to export a media source from an application. However, when
the SelectConfiguration call finishes bluetoothd crashes.

Looking at the code there is no check that the return from the
callback actually contains an array before trying to extract the array
content.

Adding a check avoids the crash in bluetoothd.

I am not sure why the return value does not contain a proper
capabilities array but that is another issue.

Sending a patch that fixes the problem for me.

Thanks

Michal

--001a11441f10873158052514c1ae
Content-Type: text/x-patch; charset=US-ASCII; name="debug_crash.patch"
Content-Disposition: attachment; filename="debug_crash.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ih9onnqg0

SW5kZXg6IGJsdWV6LTUuMzYvcHJvZmlsZXMvYXVkaW8vbWVkaWEuYwo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBi
bHVlei01LjM2Lm9yaWcvcHJvZmlsZXMvYXVkaW8vbWVkaWEuYworKysgYmx1ZXotNS4zNi9wcm9m
aWxlcy9hdWRpby9tZWRpYS5jCkBAIC0yOTIsNiArMjkyLDEyIEBAIHN0YXRpYyB2b2lkIGVuZHBv
aW50X3JlcGx5KERCdXNQZW5kaW5nQ2EKIAogCQlkYnVzX21lc3NhZ2VfaXRlcl9pbml0KHJlcGx5
LCAmYXJncyk7CiAKKwkJaWYgKGRidXNfbWVzc2FnZV9pdGVyX2dldF9hcmdfdHlwZSgmYXJncykg
IT0gREJVU19UWVBFX0FSUkFZKSB7CisJCQllcnJvcigiU2VsZWN0Q29uZmlndXJhdGlvbiBkaWQg
bm90IHJldHVybiBhbiBhcnJheTogJXMiLAorCQkJCWRidXNfbWVzc2FnZV9nZXRfc2lnbmF0dXJl
KHJlcGx5KSk7CisJCQlnb3RvIGRvbmU7CisJCX0KKwogCQlkYnVzX21lc3NhZ2VfaXRlcl9yZWN1
cnNlKCZhcmdzLCAmYXJyYXkpOwogCiAJCWRidXNfbWVzc2FnZV9pdGVyX2dldF9maXhlZF9hcnJh
eSgmYXJyYXksICZjb25maWd1cmF0aW9uLCAmc2l6ZSk7Cg==
--001a11441f10873158052514c1ae--
