Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC9721ADC3
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746024032; cv=none; b=dbxrftAR5qQR71PD+Zt+jx/FuRaeI9HZjMz6JyrgfgAWFqMollfgN6swwIQ+PFT62Jtxv1A4Glfhx9gsauKaDuD3EzOyKA0cM6CAkR9UM6o1Rm7r3K7L4aixzyhOtafHMmAtjP+Myg6R8xHuXzrM4tlgXrjyecqH4LbnOBfB+nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746024032; c=relaxed/simple;
	bh=jHSapByIhBkxceCFjKYwPIhAFb97gM6BTtjx6Nl1b7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RaIKTcb1kLbNOlJX+7HNJDpWogcbTKqD/5OZeW4LH52vRh/vDeF55nTMYNYi6dVvQxvGJdBdis6+gNfRu0MRYIHVLr0k/j9HXqG0lCPvGthZw8sdlIRe9CRmkOgn7xsQNUtck/I1QNW+JTY9aDkP++/Hsf07sRp7T4G2eduNA2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 44E2443A31;
	Wed, 30 Apr 2025 14:40:28 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ] shell: Clarify "mode" variable
Date: Wed, 30 Apr 2025 16:40:26 +0200
Message-ID: <20250430144027.2117104-1-hadess@hadess.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeileeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepffetkedtjeduvdfhtdeftddvteegieeltefhtefgtdehkeevgfeuieffhfevhfefnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeholhhimhhpihgtrddrpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgruggvshhssehhrgguvghsshdrnhgvth
X-GND-Sasl: hadess@hadess.net

It's unclear what that variable did, and which value corresponded to
which state, so replace it with a typed enum so that conditionals are
more easily parsed.
---
 src/shared/shell.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 631a07f35625..6ab4acfd0ccf 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -65,13 +65,18 @@ struct input {
 	FILE *f;
 };
 
+typedef enum {
+     MODE_INTERACTIVE     = 0,
+     MODE_NON_INTERACTIVE = 1
+} mode_type_t;
+
 static struct {
 	bool init;
 	char *name;
 	char history[256];
 	int argc;
 	char **argv;
-	bool mode;
+	mode_type_t mode;
 	bool zsh;
 	bool monitor;
 	int timeout;
@@ -708,7 +713,7 @@ void bt_shell_printf(const char *fmt, ...)
 	if (queue_isempty(data.inputs))
 		return;
 
-	if (data.mode) {
+	if (data.mode == MODE_NON_INTERACTIVE) {
 		va_start(args, fmt);
 		vprintf(fmt, args);
 		va_end(args);
@@ -833,7 +838,7 @@ void bt_shell_prompt_input(const char *label, const char *msg,
 {
 	char *str;
 
-	if (!data.init || data.mode)
+	if (!data.init || data.mode == MODE_NON_INTERACTIVE)
 		return;
 
 	if (data.saved_prompt) {
@@ -1192,7 +1197,7 @@ static void signal_callback(int signum, void *user_data)
 
 	switch (signum) {
 	case SIGINT:
-		if (!queue_isempty(data.inputs) && !data.mode) {
+		if (!queue_isempty(data.inputs) && data.mode == MODE_INTERACTIVE) {
 			rl_replace_line("", 0);
 			rl_crlf();
 			rl_on_new_line();
@@ -1210,7 +1215,7 @@ static void signal_callback(int signum, void *user_data)
 		/* fall through */
 	case SIGTERM:
 		if (!terminated) {
-			if (!data.mode) {
+			if (data.mode == MODE_INTERACTIVE) {
 				rl_replace_line("", 0);
 				rl_crlf();
 			}
@@ -1266,7 +1271,7 @@ done:
 
 static void rl_init(void)
 {
-	if (data.mode)
+	if (data.mode == MODE_NON_INTERACTIVE)
 		return;
 
 	/* Allow conditional parsing of the ~/.inputrc file. */
@@ -1346,7 +1351,7 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 			usage(argc, argv, opt);
 			data.argc = 1;
 			data.argv = &cmplt;
-			data.mode = 1;
+			data.mode = MODE_NON_INTERACTIVE;
 			goto done;
 		case 's':
 			if (optarg && data.init_fd < 0) {
@@ -1400,10 +1405,10 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 	data.argc = argc - optind;
 	data.argv = argv + optind;
 	optind = 0;
-	data.mode = (data.argc > 0);
+	data.mode = (data.argc > 0) ? MODE_NON_INTERACTIVE : MODE_INTERACTIVE;
 
 done:
-	if (data.mode)
+	if (data.mode == MODE_NON_INTERACTIVE)
 		bt_shell_set_env("NON_INTERACTIVE", &data.mode);
 
 	mainloop_init();
@@ -1420,7 +1425,7 @@ done:
 
 static void rl_cleanup(void)
 {
-	if (data.mode)
+	if (data.mode == MODE_NON_INTERACTIVE)
 		return;
 
 	if (data.history[0] != '\0')
@@ -1540,7 +1545,7 @@ void bt_shell_quit(int status)
 
 void bt_shell_noninteractive_quit(int status)
 {
-	if (!data.mode || data.timeout) {
+	if (data.mode == MODE_INTERACTIVE || data.timeout) {
 		bt_shell_dequeue_exec();
 		return;
 	}
@@ -1581,7 +1586,7 @@ void bt_shell_set_prompt(const char *string, const char *color)
 {
 	char *prompt;
 
-	if (!data.init || data.mode)
+	if (!data.init || data.mode == MODE_NON_INTERACTIVE)
 		return;
 
 	/* Envelope color within RL_PROMPT_START_IGNORE (\001) and
@@ -1614,12 +1619,12 @@ bool bt_shell_attach(int fd)
 	if (!input)
 		return false;
 
-	if (!data.mode) {
+	if (data.mode == MODE_INTERACTIVE) {
 		io_set_read_handler(input->io, input_read, input, NULL);
 		io_set_disconnect_handler(input->io, input_hup, input, NULL);
 	}
 
-	if (data.mode) {
+	if (data.mode == MODE_NON_INTERACTIVE) {
 		if (shell_exec(data.argc, data.argv) < 0) {
 			bt_shell_noninteractive_quit(EXIT_FAILURE);
 			return true;
-- 
2.49.0

