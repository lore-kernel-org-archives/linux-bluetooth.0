Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450293;
	b=snlqhNJfVhxKUIBbgXwNKRT/6zd5dH7oBVh3hwhLKQV4cLtJrEspJb43C2EuJ3FGSKt7
	 1H+d8nfdseTCAV/M4gkbdvUybUgktnQH5ze5t72E5ZGXRJbU8XLRmjuyz+QkzLVPx4YRb
	 V5Rf3oYouLY/SMbvRaIYGluPWTHSXPjqF1NzOOcU6CtH0JCEDPxH1d0ihsbuEa5O346DZ
	 FPmHTnCOsh5S2k8bqNMd7J+QfJOoCWmgBJGc/cxyDYq2D5u+nVF/s02s9tLP0IIi0D+zU
	 PPwmhoVpPKGPe8xSotS1YPh0d5lu5iMbWaReBREJ/PL8BEdQdMJI9Hc7WbLMwY/kT+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450293;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UgJl7+cieGIekv7mnX+Y6Qk6WY8zk6mtPS9fb/2B2BM=;
	b=QkdmCnsHlRCVZ3kHQqAQriNVAv7fndPhwhJRcMn3SZ5Gac9GKj0FhGDVECkgCAj3AB1F
	 98pCHy9uinFIfWT5dOJIjsby3S6XOsZTQkGSqc5rSAo4b3Q2meEbeawOlrUxvfr8G3L9F
	 4a1z5LH/af1xT/INNa7iymNCY48AThT2XCI70MBZaMuBs9z+y57NPcwX4Q5L8e2TYIrCx
	 qNTcojDVA8PS4tfOHZ7xxLd5aWWh5w0hW0xiy4lU/bW5fuLLDSLWRAmncCjmC3yPabyZh
	 kWvzKP7HD5Wopi+hKlvpNftfmxJV9EQ8CdGW1PQw+ZiMJkymculhfzboIqxi+uk343w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b="o//NkQCk";
	arc=none smtp.remote-ip=109.224.244.17
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B72606A32D
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 02:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60B72606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=o//NkQCk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794450289; x=1794709489;
	bh=UgJl7+cieGIekv7mnX+Y6Qk6WY8zk6mtPS9fb/2B2BM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=o//NkQCkTkanMO7UDL7sSmMFTeIX5KF7MscG4JxS72rG9fr/1HVPv7/nX16tgtUl1
	 wry16Y3YmAkYsSdHVR3aKZXIUQ2SdT+P/gBD+vruzesxftfIIE9wcgPPleDZ3DxILX
	 nzaGtspIeGEIzLIp6XhcxgvSsH/yQQwZ3ApSMwx6N+UWU/SGlRs6LVa2pEzZPmHqY9
	 y6ZvezjBwEBaKyU6nUfkuLDi05oBL3F4/PEq1kAMIP10W8fTit/hK/Xy8mr0OWkvFF
	 9kzJTh2TRzyQQG5AAw4dNwHpden95lYZVcWPaEoJp52aWJkp2UDFIeH4LGgy8L/HQp
	 I/1jX4E6KpQ2g==
Date: Thu, 12 Nov 2026 02:24:45 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org
Subject: [RFC PATCH] CheckPatch: accept required AI attribution diagnostics
Message-ID: <20261112022434.185405-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 6a344e70d6633f07286d4ff54627f29d6a3932c9
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Recognize legacy signature errors only for one well-formed Assisted-by
trailer at its exact patch path and commit-message line. Keep the raw
diagnostics in the result and leave patch bytes unchanged.

Fail checker exits without a recognized diagnostic instead of reporting
success. Test attribution formats, source errors, missing sign-offs and
both orderings of mixed passing and failing patches.

Assisted-by: Codex:GPT-6
---
Reported CI: https://github.com/bluez/bluetooth-next/pull/1084

Local validation: 18 checker tests pass. Both exact signed v8 patches
fail with the original checker and pass with this change, byte-for-byte.
Source, sign-off and mixed-series failures remain fatal.

 ci/checkpatch.py         |  55 ++++++++-
 tests/test_checkpatch.py | 243 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 295 insertions(+), 3 deletions(-)
 create mode 100644 tests/test_checkpatch.py

diff --git a/ci/checkpatch.py b/ci/checkpatch.py
index 275ce62..198a57a 100755
--- a/ci/checkpatch.py
+++ b/ci/checkpatch.py
@@ -1,4 +1,5 @@
 import os
+import re
 import sys
=20
 sys.path.insert(0, '../libs')
@@ -6,6 +7,39 @@ from libs import cmd_run
=20
 from ci import Base, Verdict, EndTest, submit_pw_check
=20
+
+def assisted_by_only(patch_file, ret, stdout, stderr):
+    """Recognize only legacy checkpatch diagnostics on AI attribution."""
+    if ret !=3D 1 or stderr.strip():
+        return False
+
+    with open(patch_file, encoding=3D'utf-8', errors=3D'replace') as patch=
:
+        message =3D re.split(r'^---(?:\s.*)?$|^diff --git ', patch.read(),
+                           maxsplit=3D1, flags=3Dre.MULTILINE)[0]
+
+    trailers =3D [(number, line)
+                for number, line in enumerate(message.splitlines(), 1)
+                if line.startswith('Assisted-by:')]
+    if len(trailers) !=3D 1:
+        return False
+
+    number, trailer =3D trailers[0]
+    match =3D re.fullmatch(r'Assisted-by: (LLM|[\w.+-]+:[\w.+-]+(?: [\w.+-=
]+)*)',
+                         trailer, flags=3Dre.ASCII)
+    if not match:
+        return False
+    value =3D match.group(1)
+
+    prefix =3D f'{patch_file}:{number}: '
+    allowed =3D {
+        prefix + 'WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-b=
y:',
+        prefix + f"ERROR:BAD_SIGN_OFF: Unrecognized email address: '{value=
}'",
+    }
+    diagnostics =3D [line for line in stdout.splitlines() if line]
+    return (bool(diagnostics) and len(diagnostics) =3D=3D len(set(diagnost=
ics))
+            and set(diagnostics) <=3D allowed)
+
+
 class CheckPatch(Base):
     """Check Patch class
     This class runs the checkpatch.pl with the patches in the series.
@@ -41,9 +75,13 @@ class CheckPatch(Base):
             if ret =3D=3D 0:
                 # CheckPatch PASS
                 self.log_dbg("Test result PASSED")
+                details =3D "CheckPatch PASS"
+                if stdout.strip():
+                    details +=3D "\n" + stdout
+                    self.output +=3D f"{patch['name']}\n{stdout}\n"
                 submit_pw_check(self.ci_data.pw, patch,
                                 self.name, Verdict.PASS,
-                                "CheckPatch PASS",
+                                details,
                                 None, self.ci_data.config['dry_run'])
                 continue
=20
@@ -69,6 +107,12 @@ class CheckPatch(Base):
                 self.add_failure(msg)
                 continue
=20
+            # A failed checker without a recognized diagnostic still fails=
.
+            submit_pw_check(self.ci_data.pw, patch,
+                            self.name, Verdict.FAIL, outstr,
+                            None, self.ci_data.config['dry_run'])
+            self.add_failure(msg)
+
         # Overall result
         if self.verdict =3D=3D Verdict.FAIL:
             self.log_info(f"Test Verdict: {self.verdict.name}")
@@ -78,7 +122,7 @@ class CheckPatch(Base):
         self.log_info(f"Test Verdict: {self.verdict.name}")
=20
     def _checkpatch(self, patch):
-        cmd =3D [self.checkpatch_pl]
+        cmd =3D [self.checkpatch_pl, '--show-types', '--terse', '--no-summ=
ary']
         if self.ignore:
             cmd.append('--ignore')
             cmd.append(self.ignore)
@@ -88,7 +132,12 @@ class CheckPatch(Base):
                                          f"{patch['id']}.patch"))
         self.log_dbg(f"Patch file: {patch_file}")
         cmd.append(patch_file)
-        return cmd_run(cmd, cwd=3Dself.ci_data.src_dir)
+        ret, stdout, stderr =3D cmd_run(cmd, cwd=3Dself.ci_data.src_dir)
+        if assisted_by_only(patch_file, ret, stdout, stderr):
+            stdout =3D ("Accepted required Assisted-by metadata diagnostic=
s; "
+                      "attribution preserved:\n" + stdout)
+            return 0, stdout, stderr
+        return ret, stdout, stderr
=20
     def post_run(self):
         self.log_dbg("Post Run...")
diff --git a/tests/test_checkpatch.py b/tests/test_checkpatch.py
new file mode 100644
index 0000000..5e6d66f
--- /dev/null
+++ b/tests/test_checkpatch.py
@@ -0,0 +1,243 @@
+# SPDX-License-Identifier: GPL-2.0-only
+import importlib.util
+import os
+from pathlib import Path
+import shutil
+import sys
+import tempfile
+from types import ModuleType, SimpleNamespace
+import unittest
+from unittest.mock import patch
+
+ROOT =3D Path(__file__).resolve().parents[1]
+
+
+def load(name, path):
+    spec =3D importlib.util.spec_from_file_location(name, path)
+    module =3D importlib.util.module_from_spec(spec)
+    sys.modules[name] =3D module
+    spec.loader.exec_module(module)
+    return module
+
+
+# Load the real checker, base and command runner without importing API cli=
ents.
+with patch.dict(sys.modules):
+    libs =3D ModuleType('libs')
+    sys.modules['libs'] =3D libs
+    utils =3D load('libs.utils', ROOT / 'libs/utils.py')
+    libs.utils =3D utils
+    libs.cmd_run =3D utils.cmd_run
+    libs.log_debug =3D utils.log_debug
+    ci =3D ModuleType('ci')
+    sys.modules['ci'] =3D ci
+    base =3D load('ci.base', ROOT / 'ci/base.py')
+    for name in ('Base', 'Verdict', 'EndTest', 'submit_pw_check'):
+        setattr(ci, name, getattr(base, name))
+    checker =3D load('ci.checkpatch', ROOT / 'ci/checkpatch.py')
+
+
+MESSAGE =3D '''From: Test Author <test@example.com>
+Subject: [PATCH] test: Correct the returned value
+
+Correct the returned value.
+
+{trailer}
+---
+ sample.c | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/sample.c b/sample.c
+--- a/sample.c
++++ b/sample.c
+@@ -1,4 +1,4 @@
+ int sample(void)
+ {{
+-\treturn 0;
++\treturn 1;
+ }}
+'''
+
+
+class AttributionTests(unittest.TestCase):
+    def setUp(self):
+        self.directory =3D tempfile.TemporaryDirectory()
+        self.addCleanup(self.directory.cleanup)
+        self.path =3D Path(self.directory.name) / 'sample.patch'
+        self.message('Assisted-by: LLM')
+
+    def message(self, trailer):
+        self.path.write_text(MESSAGE.format(trailer=3Dtrailer))
+
+    def diagnostics(self, value=3D'LLM'):
+        number =3D self.path.read_text().splitlines().index('Assisted-by: =
' + value) + 1
+        prefix =3D f'{self.path}:{number}: '
+        return (prefix + 'WARNING:BAD_SIGN_OFF: Non-standard signature: As=
sisted-by:\n'
+                + prefix + f"ERROR:BAD_SIGN_OFF: Unrecognized email addres=
s: '{value}'\n")
+
+    def accepted(self, output, status=3D1, stderr=3D''):
+        return checker.assisted_by_only(str(self.path), status, output, st=
derr)
+
+    def test_known_formats(self):
+        for value in ('LLM', 'Codex:GPT-6', 'OpenCode:gpt-6.1-sol',
+                      'Claude:claude-3-opus sparse coccinelle'):
+            with self.subTest(value=3Dvalue):
+                self.message('Assisted-by: ' + value)
+                self.assertTrue(self.accepted(self.diagnostics(value)))
+
+    def test_unrelated_diagnostic(self):
+        self.assertFalse(self.accepted(self.diagnostics() +
+                                      f'{self.path}:20: ERROR:CODE_INDENT:=
 bad indent\n'))
+
+    def test_bad_status_or_stderr(self):
+        for status, stderr in ((2, ''), (-9, ''), (1, 'checker failed')):
+            with self.subTest(status=3Dstatus, stderr=3Dstderr):
+                self.assertFalse(self.accepted(self.diagnostics(), status,=
 stderr))
+
+    def test_duplicate_diagnostic(self):
+        self.assertFalse(self.accepted(self.diagnostics() * 2))
+
+    def test_wrong_location(self):
+        self.assertFalse(self.accepted(self.diagnostics().replace(':6:', '=
:7:')))
+
+    def test_wrong_path(self):
+        self.assertFalse(self.accepted(self.diagnostics().replace('sample.=
patch', 'other.patch')))
+
+    def test_missing_duplicate_or_invalid_trailer(self):
+        output =3D self.diagnostics()
+        for trailer in ('', 'Assisted-by: LLM\nAssisted-by: LLM',
+                        'Assisted-by: nonsense', 'Assisted-by: LLM ',
+                        'Assisted-by:', 'Assisted-by:LLM', 'Assisted-by:\t=
LLM',
+                        'Assisted-by:  LLM', 'Assisted-by: LLM <bot@exampl=
e.com>'):
+            with self.subTest(trailer=3Dtrailer):
+                self.message(trailer)
+                self.assertFalse(self.accepted(output))
+
+    def test_source_line_is_not_metadata(self):
+        output =3D self.diagnostics()
+        self.message('')
+        with self.path.open('a') as stream:
+            stream.write('Assisted-by: LLM\n')
+        self.assertFalse(self.accepted(output))
+
+    def test_empty_or_unknown_output(self):
+        for output in ('', 'checker crashed', self.diagnostics() + 'NOTE: =
unexpected\n'):
+            with self.subTest(output=3Doutput):
+                self.assertFalse(self.accepted(output))
+
+    def make_checker(self, content=3DNone, ignore=3D'UNKNOWN_COMMIT_ID,MIS=
SING_SIGN_OFF'):
+        if content is not None:
+            self.path.write_text(content)
+        original =3D self.path.read_bytes()
+
+        def save_patch(_identifier, destination):
+            Path(destination).write_bytes(original)
+            return destination
+
+        executable =3D os.environ.get('CHECKPATCH') or shutil.which('check=
patch.pl')
+        if not executable:
+            self.skipTest('Set CHECKPATCH to a kernel scripts/checkpatch.p=
l')
+        self.data =3D SimpleNamespace(
+            pw=3DSimpleNamespace(save_patch_mbox=3Dsave_patch),
+            patch_root=3Dself.directory.name,
+            src_dir=3Dstr(Path(executable).resolve().parents[1]),
+            config=3D{'dry_run': True},
+            series=3D{'patches': [{'id': 1, 'name': 'test patch'}]})
+        return checker.CheckPatch(self.data, checkpatch_pl=3Dexecutable, i=
gnore=3Dignore)
+
+    def test_real_checker_accepts_attribution_without_mutating_patch(self)=
:
+        for value in ('LLM', 'Codex:GPT-6', 'OpenCode:gpt-6.1-sol'):
+            with self.subTest(value=3Dvalue):
+                self.message('Assisted-by: ' + value)
+                before =3D self.path.read_bytes()
+                tested =3D self.make_checker()
+                with patch.object(checker, 'submit_pw_check') as submit:
+                    tested.run()
+                self.assertEqual(tested.verdict, base.Verdict.PASS)
+                self.assertIn('Accepted required Assisted-by', tested.outp=
ut)
+                self.assertEqual(submit.call_args.args[3], base.Verdict.PA=
SS)
+                self.assertEqual(self.path.read_bytes(), before)
+                self.assertEqual((Path(self.directory.name) / '1.patch').r=
ead_bytes(), before)
+
+    def test_real_checker_rejects_source_and_signature_errors(self):
+        for content in (
+                MESSAGE.format(trailer=3D'Assisted-by: LLM').replace('+\tr=
eturn 1;', '+ return 1;'),
+                MESSAGE.format(trailer=3D'Assisted-by: LLM\nReviewed-by: n=
onsense'),
+                MESSAGE.format(trailer=3D'Assisted-by: nonsense')):
+            with self.subTest(content=3Dcontent):
+                tested =3D self.make_checker(content)
+                with patch.object(checker, 'submit_pw_check') as submit:
+                    with self.assertRaises(base.EndTest):
+                        tested.run()
+                self.assertEqual(tested.verdict, base.Verdict.FAIL)
+                self.assertEqual(submit.call_count, 1)
+
+    def test_real_checker_accepts_clean_patch_without_attribution(self):
+        self.message('')
+        tested =3D self.make_checker()
+        with patch.object(checker, 'submit_pw_check'):
+            tested.run()
+        self.assertEqual(tested.verdict, base.Verdict.PASS)
+        self.assertNotIn('Accepted required', tested.output)
+
+    def test_raw_attribution_diagnostics_remain_in_pass_report(self):
+        tested =3D self.make_checker()
+        with patch.object(checker, 'submit_pw_check') as submit:
+            tested.run()
+        self.assertEqual(tested.verdict, base.Verdict.PASS)
+        self.assertEqual(submit.call_count, 1)
+        for diagnostic in ('WARNING:BAD_SIGN_OFF: Non-standard signature: =
Assisted-by:',
+                           "ERROR:BAD_SIGN_OFF: Unrecognized email address=
: 'LLM'"):
+            self.assertIn(diagnostic, tested.output)
+            self.assertIn(diagnostic, submit.call_args.args[4])
+
+    def test_real_checker_rejects_duplicate_metadata(self):
+        self.message('Assisted-by: LLM\nAssisted-by: LLM')
+        tested =3D self.make_checker()
+        with patch.object(checker, 'submit_pw_check') as submit:
+            with self.assertRaises(base.EndTest):
+                tested.run()
+        self.assertEqual(tested.verdict, base.Verdict.FAIL)
+        self.assertEqual(submit.call_count, 1)
+
+    def test_series_failure_is_not_hidden_by_accepted_metadata(self):
+        good =3D (0, 'Accepted required metadata', '')
+        bad =3D (1, 'ERROR: other', '')
+        for results in ([good, bad], [bad, good]):
+            with self.subTest(results=3Dresults):
+                tested =3D self.make_checker()
+                self.data.series['patches'].append({'id': 2, 'name': 'bad =
patch'})
+                with patch.object(tested, '_checkpatch', side_effect=3Dres=
ults):
+                    with patch.object(checker, 'submit_pw_check') as submi=
t:
+                        with self.assertRaises(base.EndTest):
+                            tested.run()
+                self.assertEqual(tested.verdict, base.Verdict.FAIL)
+                self.assertEqual(submit.call_count, 2)
+
+    def test_real_checker_does_not_ignore_missing_signoff(self):
+        tested =3D self.make_checker(ignore=3D'UNKNOWN_COMMIT_ID')
+        with patch.object(checker, 'submit_pw_check'):
+            with self.assertRaises(base.EndTest):
+                tested.run()
+        self.assertEqual(tested.verdict, base.Verdict.FAIL)
+        self.assertIn('MISSING_SIGN_OFF', tested.output)
+
+    def test_abnormal_checker_exit_is_fatal(self):
+        tested =3D self.make_checker()
+        with patch.object(checker, 'cmd_run', return_value=3D(2, '', 'fail=
ed')):
+            with patch.object(checker, 'submit_pw_check') as submit:
+                with self.assertRaises(base.EndTest):
+                    tested.run()
+        self.assertEqual(tested.verdict, base.Verdict.FAIL)
+        self.assertEqual(submit.call_count, 1)
+
+    def test_warning_only_does_not_submit_twice(self):
+        tested =3D self.make_checker()
+        with patch.object(checker, 'cmd_run', return_value=3D(1, 'WARNING:=
 other', '')):
+            with patch.object(checker, 'submit_pw_check') as submit:
+                with self.assertRaises(base.EndTest):
+                    tested.run()
+        self.assertEqual(submit.call_count, 1)
+
+
+if __name__ =3D=3D '__main__':
+    unittest.main()

base-commit: 60348956fc7bad52a64e802f3e90f90c03ba8860
--=20
2.56.0


