Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 3/3] android: Add help and quit to haltest
Date: Mon, 21 Oct 2013 16:02:16 +0200
Message-ID: <1382364136-13665-4-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1382364136-13665-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1382364136-13665-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds help and quit commands.
It also adds tab completion for commands (it used to work
for interfaces).
---
 android/client/haltest.c       |  151 ++++++++++++++++++++++++++++++++++------
 android/client/if-main.h       |    6 ++
 android/client/tabcompletion.c |  151 ++++++++++++++++++++++++++++------------
 3 files changed, 240 insertions(+), 68 deletions(-)

diff --git a/android/client/haltest.c b/android/client/haltest.c
index 6b37f33..4864de1 100644
--- a/android/client/haltest.c
+++ b/android/client/haltest.c
@@ -34,6 +34,31 @@ const struct interface *interfaces[] = {
 	NULL
 };
 
+static struct method commands[];
+
+struct method *get_method(struct method *methods, const char *name)
+{
+	while (strcmp(methods->name, "") != 0) {
+		if (strcmp(methods->name, name) == 0)
+			return methods;
+		methods++;
+	}
+	return NULL;
+}
+
+/* function returns interface of given name or NULL if not found */
+const struct interface *get_interface(const char *name)
+{
+	int i;
+
+	for (i = 0; interfaces[i] != NULL; ++i) {
+		if (strcmp(interfaces[i]->name, name) == 0)
+			break;
+	}
+
+	return interfaces[i];
+}
+
 int haltest_error(const char *format, ...)
 {
 	va_list args;
@@ -64,6 +89,95 @@ int haltest_warn(const char *format, ...)
 	return ret;
 }
 
+static void help_print_interface(const struct interface *i)
+{
+	struct method *m;
+
+	for (m = i->methods; strcmp(m->name, "") != 0; m++)
+		haltest_info("%s %s %s\n", i->name, m->name,
+						(m->help ? m->help : ""));
+}
+
+/* Help completion */
+static void help_c(int argc, const char **argv,
+					enum_func *penum_func, void **puser)
+{
+	if (argc == 2)
+		*penum_func = interface_name;
+}
+
+/* Help execution */
+static void help_p(int argc, const char **argv)
+{
+	const struct method *m = commands;
+	const struct interface **ip = interfaces;
+	const struct interface *i;
+
+	if (argc == 1) {
+		terminal_print("haltest allows to call Android HAL methods.\n");
+		terminal_print("\nAvailable commands:\n");
+		while (0 != strcmp(m->name, "")) {
+			terminal_print("\t%s %s\n", m->name,
+						(m->help ? m->help : ""));
+			m++;
+		}
+		terminal_print("\nAvailable interfaces to use:\n");
+		while (NULL != *ip) {
+			terminal_print("\t%s\n", (*ip)->name);
+			ip++;
+		}
+		terminal_print("\nTo get help on methods for each interface type:\n");
+		terminal_print("\n\thelp <inerface>\n");
+		terminal_print("\nBasic scenario:\n\tadapter init\n");
+		terminal_print("\tadapter enable\n\tadapter start_discovery\n");
+		terminal_print("\tadapter get_profile_interface handsfree\n");
+		terminal_print("\thandsfree init\n\n");
+		return;
+	}
+	i = get_interface(argv[1]);
+	if (i == NULL) {
+		haltest_error("No such interface\n");
+		return;
+	}
+	help_print_interface(i);
+}
+
+/* quit/exit execution */
+static void quit_p(int argc, const char **argv)
+{
+	exit(0);
+}
+
+/* Commands available without interface */
+static struct method commands[] = {
+	STD_METHODCH(help, "[<interface>]"),
+	STD_METHOD(quit),
+	METHOD("exit", quit_p, NULL, NULL),
+	END_METHOD
+};
+
+/* Gets comman by name */
+struct method *get_command(const char *name)
+{
+	return get_method(commands, name);
+}
+
+/* Function to enumerate interface names */
+const char *interface_name(void *v, int i)
+{
+	return interfaces[i] ? interfaces[i]->name : NULL;
+}
+
+/* Function to enumerate command and interface names */
+const char *command_name(void *v, int i)
+{
+	int cmd_cnt = (int) (sizeof(commands)/sizeof(commands[0]) - 1);
+	if (i >= cmd_cnt)
+		return interface_name(v, i - cmd_cnt);
+	else
+		return commands[i].name;
+}
+
 /*
  * This function changes input parameter line_buffer so it has
  * null termination after each token (due to strtok)
@@ -91,7 +205,7 @@ static void process_line(char *line_buffer)
 	char *argv[10];
 	int argc;
 	int i = 0;
-	int j;
+	struct method *m;
 
 	argc = command_line_to_argv(line_buffer, argv, 10);
 	if (argc < 1)
@@ -103,32 +217,23 @@ static void process_line(char *line_buffer)
 			continue;
 		}
 		if (argc < 2 || strcmp(argv[1], "?") == 0) {
-			struct method *m = &interfaces[i]->methods[0];
-			while (strcmp(m->name, "")) {
-				haltest_info("%s %s %s\n", argv[0],
-						m->name,
-						(m->help ? m->help : ""));
-				m++;
-			}
+			help_print_interface(interfaces[i]);
 			return;
 		}
-		j = 0;
-		while (strcmp(interfaces[i]->methods[j].name, "")) {
-			if (strcmp(interfaces[i]->methods[j].name, argv[1])) {
-				j++;
-				continue;
-			}
-			interfaces[i]->methods[j].func(argc,
-							(const char **)argv);
-			break;
+		m = get_method(interfaces[i]->methods, argv[1]);
+		if (m != NULL) {
+			m->func(argc, (const char **) argv);
+			return;
 		}
-		if (strcmp(interfaces[i]->methods[j].name, "") == 0)
-			printf("No function %s found\n", argv[1]);
-		break;
+		haltest_error("No function %s found\n", argv[1]);
+		return;
 	}
-
-	if (interfaces[i] == NULL)
-		printf("No such interface %s\n", argv[0]);
+	/* No interface, try commands */
+	m = get_command(argv[0]);
+	if (m == NULL)
+		haltest_error("No such command %s\n", argv[0]);
+	else
+		m->func(argc, (const char **) argv);
 }
 
 /* called when there is something on stdin */
diff --git a/android/client/if-main.h b/android/client/if-main.h
index b6bbf05..6d2b0cb 100644
--- a/android/client/if-main.h
+++ b/android/client/if-main.h
@@ -107,8 +107,14 @@ int haltest_warn(const char *format, ...);
  * Enumerator for discovered devices, to be used as tab completion enum_func
  */
 const char *enum_devices(void *v, int i);
+const char *interface_name(void *v, int i);
+const char *command_name(void *v, int i);
 void add_remote_device(const bt_bdaddr_t *addr);
 
+const struct interface *get_interface(const char *name);
+struct method *get_method(struct method *methods, const char *name);
+struct method *get_command(const char *name);
+
 /* Helper macro for executing function on interface and printing BT_STATUS */
 #define EXEC(f, ...) \
 	{ \
diff --git a/android/client/tabcompletion.c b/android/client/tabcompletion.c
index e9c9921..2b95591 100644
--- a/android/client/tabcompletion.c
+++ b/android/client/tabcompletion.c
@@ -29,33 +29,16 @@ typedef struct split_arg {
 	char ntcopy[1]; /* null terminated copy of argument */
 } split_arg_t;
 
-/* function returns interface of given name or NULL if not found */
-static const struct interface *get_interface(const char *name)
-{
-	int i;
-
-	for (i = 0; interfaces[i] != NULL; ++i) {
-		if (strcmp(interfaces[i]->name, name) == 0)
-			break;
-	}
-
-	return interfaces[i];
-}
-
 /* function returns method of given name or NULL if not found */
-static const struct method *get_method(const char *iname, const char *mname)
+static const struct method *get_interface_method(const char *iname,
+							const char *mname)
 {
-	int i;
 	const struct interface *iface = get_interface(iname);
 
 	if (iface == NULL)
 		return NULL;
 
-	for (i = 0; iface->methods[i].name[0]; ++i) {
-		if (0 == strcmp(iface->methods[i].name, mname))
-			return &iface->methods[i];
-	}
-	return NULL;
+	return get_method(iface->methods, mname);
 }
 
 /* prints matching elements */
@@ -113,12 +96,6 @@ static int split_command(const char *line_buffer, int size,
 	return argc;
 }
 
-/* Function to enumerate interface names */
-static const char *interface_name(void *v, int i)
-{
-	return interfaces[i] ? interfaces[i]->name : NULL;
-}
-
 /* Function to enumerate method names */
 static const char *methods_name(void *v, int i)
 {
@@ -142,7 +119,7 @@ struct command_completion_args {
 /*
  * complete command line
  */
-static void command_completion(struct command_completion_args *args)
+static void tab_completion(struct command_completion_args *args)
 {
 	const char *name = args->typed;
 	const int len = strlen(name);
@@ -211,15 +188,15 @@ static void command_completion(struct command_completion_args *args)
 }
 
 /* interface completion */
-static void interface_completion(split_arg_t *arg)
+static void command_completion(split_arg_t *arg)
 {
 	struct command_completion_args args = {
 		.arg = arg,
 		.typed = arg->ntcopy,
-		.func = interface_name
+		.func = command_name
 	};
 
-	command_completion(&args);
+	tab_completion(&args);
 }
 
 /* method completion */
@@ -235,17 +212,86 @@ static void method_completion(const struct interface *iface, split_arg_t *arg)
 	if (iface == NULL)
 		return;
 
-	command_completion(&args);
+	tab_completion(&args);
+}
+
+static const char *bold = "\x1b[1m";
+static const char *normal = "\x1b[0m";
+
+static bool find_nth_argument(const char *str, int n,
+						const char **s, const char **e)
+{
+	const char *p = str;
+	int argc = 0;
+	*e = NULL;
+
+	while (p != NULL && *p != 0) {
+
+		while (isspace(*p))
+			++p;
+
+		if (n == argc)
+			*s = p;
+
+		if (*p == '[') {
+			p = strchr(p, ']');
+			if (p != NULL)
+				*e = ++p;
+		} else if (*p == '<') {
+			p = strchr(p, '>');
+			if (p != NULL)
+				*e = ++p;
+		} else {
+			*e = strchr(p, ' ');
+			if (*e == NULL)
+				*e = p + strlen(p);
+			p = *e;
+		}
+
+		if (n == argc)
+			break;
+
+		argc++;
+		*e = NULL;
+	}
+	return *e != NULL;
 }
 
 /* prints short help on method for interface */
 static void method_help(struct command_completion_args *args)
 {
+	int argc;
+	const split_arg_t *arg = args->arg;
+	const char *sb = NULL;
+	const char *eb = NULL;
+	const char *arg1 = "";
+	int arg1_size = 0; /* size of method field (for methods > 0) */
+
 	if (args->user_help == NULL)
 		return;
 
-	haltest_info("%s %s %s\n", args->arg->ntcopy,
-		args->arg->next->ntcopy, args->user_help);
+	for (argc = 0; arg != NULL; argc++)
+		arg = arg->next;
+
+	/* Check if this is method from interface */
+	if (get_command(args->arg->ntcopy) == NULL) {
+		/* if so help is missing interface and method name */
+		arg1 = args->arg->next->ntcopy;
+		arg1_size = strlen(arg1) + 1;
+	}
+
+	find_nth_argument(args->user_help, argc - (arg1_size ? 3 : 2),
+								&sb, &eb);
+
+	if (eb != NULL)
+		haltest_info("%s %-*s%.*s%s%.*s%s%s\n", args->arg->ntcopy,
+				arg1_size, arg1,
+				sb - (const char *) args->user_help,
+				args->user_help,
+				bold, eb - sb, sb, normal, eb);
+	else
+		haltest_info("%s %-*s%s\n", args->arg->ntcopy,
+			arg1_size, arg1, args->user_help);
 }
 
 /* So we have empty enumeration */
@@ -254,10 +300,15 @@ static const char *return_null(void *user, int i)
 	return NULL;
 }
 
-/* parameter completion function */
-static void param_completion(int argc, const split_arg_t *arg)
+/*
+ * parameter completion function
+ * argc - number of elements in arg list
+ * arg - list of arguments
+ * megthod - method to get completion from (can be NULL)
+ */
+static void param_completion(int argc, const split_arg_t *arg,
+					const struct method *method, int hlpix)
 {
-	const struct method *method;
 	int i;
 	const char *argv[argc];
 	const split_arg_t *tmp = arg;
@@ -272,9 +323,6 @@ static void param_completion(int argc, const split_arg_t *arg)
 		tmp = tmp->next;
 	}
 
-	/* Find method for <interface, name> pair */
-	method = get_method(argv[0], argv[1]);
-
 	if (method != NULL && method->complete != NULL) {
 		/* ask method for completion function */
 		method->complete(argc, argv, &args.func, &args.user);
@@ -286,7 +334,7 @@ static void param_completion(int argc, const split_arg_t *arg)
 		args.help = method_help;
 		args.user_help = (void *) method->help;
 
-		command_completion(&args);
+		tab_completion(&args);
 	}
 }
 
@@ -300,14 +348,27 @@ void process_tab(const char *line, int len)
 {
 	int argc;
 	static split_arg_t buf[(LINE_BUF_MAX * 2) / sizeof(split_arg_t)];
+	const struct method *method;
 
 	argc = split_command(line, len, buf, sizeof(buf));
 	tab_hit_count++;
 
-	if (argc == 1)
-		interface_completion(buf);
-	else if (argc == 2)
+	if (argc == 0)
+		return;
+
+	if (argc == 1) {
+		command_completion(buf);
+		return;
+	}
+	method = get_command(buf[0].ntcopy);
+	if (method != NULL) {
+		param_completion(argc, buf, method, 1);
+	} else if (argc == 2) {
 		method_completion(get_interface(buf[0].ntcopy), buf);
-	else if (argc > 2)
-		param_completion(argc, buf);
+	} else {
+		/* Find method for <interface, name> pair */
+		method = get_interface_method(buf[0].ntcopy,
+							buf[0].next->ntcopy);
+		param_completion(argc, buf, method, 2);
+	}
 }
-- 
1.7.9.5

