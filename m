Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E2415B12C
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 21:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715807632; cv=none; b=FOc/YE8QlEgwmDcnc4w2DgRPlDyqyFFCJ2ch2M/tssh3bTeFivkCU0MReXPRs/kFm1SnCuLyV1yD1m2HOcu44YW1Shw+ouTC/34kUeSE2uAtjuIP5Wmzc+uLR6GV3xijPx5ctp/ATYyZMRKzBoHkLNROkviGKHCZE74wG9FbBOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715807632; c=relaxed/simple;
	bh=a4GDk4CQujsySbBluFRcZ2/ue87HBivOXP8mltu/xMQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tQXGxmETpQ4ZG5yFf7QB2jtY4LYtrXO27At/XT1TTndkAP78heOs3ZwESor0wNBGdNbHdsp/Qm5knNccTUytr4mhuGspyjSvUFiVjWa7anbQyWtmVYYwJQ1sQ2SBFBEFeQvwy2dBgdMjSMf3tQlz5FErCM1Ba9OplmTl7x/rkvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bhmjrzBV; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bhmjrzBV"
Received: from github.com (hubbernetes-node-6f599ad.va3-iad.github.net [10.48.157.34])
	by smtp.github.com (Postfix) with ESMTPA id 945AA4E112B
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 14:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1715807628;
	bh=fJiTU0zFbbHcnX07yODk/VmEyQ6gUyOrgfBgxe0iax4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bhmjrzBVXzBPNG2l21TV+1Ukn3P2SLpoK9s1y5dfqKPup/e+8pBJRg7igLW8EQNfH
	 Xb/hdKN1mjlOcJMlaQbmQEKyzkFxgi8g3/oGIZh2g3cUC4+1Twgs3oWP9CTmU1NlaW
	 QHm/VZiuxs5TC36a2nKVwvxO23Bd/bDEXPmVP18s=
Date: Wed, 15 May 2024 14:13:48 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/78af54-d9de30@github.com>
Subject: [bluez/bluez] 449cf3: shared/util: Fix build error on malloc0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 449cf35032e5437d7beb00289a8fdd27b57e46a0
      https://github.com/bluez/bluez/commit/449cf35032e5437d7beb00289a8fd=
d27b57e46a0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-05-07 (Tue, 07 May 2024)

  Changed paths:
    M src/shared/util.h

  Log Message:
  -----------
  shared/util: Fix build error on malloc0

This fixes the parameter order of calloc which causes the following
error on recent gcc:

CC    client/mgmt.o
In file included from client/mgmt.c:43:
client/mgmt.c: In function =E2=80=98cmd_add_ext_adv_params=E2=80=99:
client/mgmt.c:5057:28: error: =E2=80=98calloc=E2=80=99 sizes specified wi=
th =E2=80=98sizeof=E2=80=99 in
the earlier argument and not in the later argument
[-Werror=3Dcalloc-transposed-args]
 5057 |     cp =3D malloc0(sizeof(*cp));
   |


  Commit: f4795bf64dbf8778fc765b7dad1b1bfb365b48d7
      https://github.com/bluez/bluez/commit/f4795bf64dbf8778fc765b7dad1b1=
bfb365b48d7
  Author: Fabrice Fontaine <fontaine.fabrice@gmail.com>
  Date:   2024-05-08 (Wed, 08 May 2024)

  Changed paths:
    M configure.ac

  Log Message:
  -----------
  configure.ac: fix sixaxis build without tools

Fix the following build failure with --enable-sixaxis --enable-udev
--disable-tools raised since version 5.73 and
9f71892b63f6b65dab874a633d88ae2dcad93a16:

sixaxis.c:(.text.sixaxis_init+0x23): undefined reference to `udev_new'

Fixes: http://autobuild.buildroot.org/results/c337d0f473c5fbb3e6cda1317ba=
06f5e2b16a43e


  Commit: d3fcc77f99da755bb364c491f71638358bdd5f09
      https://github.com/bluez/bluez/commit/d3fcc77f99da755bb364c491f7163=
8358bdd5f09
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-10 (Fri, 10 May 2024)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Use false instead of 0 for bool


  Commit: 1e22fd9adbb3283f1a081b94248e97b662256d54
      https://github.com/bluez/bluez/commit/1e22fd9adbb3283f1a081b94248e9=
7b662256d54
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-10 (Fri, 10 May 2024)

  Changed paths:
    M attrib/gatt.c

  Log Message:
  -----------
  attrib/gatt: Guard against possible integer overflow

Error: INTEGER_OVERFLOW (CWE-190): [#def30]
attrib/gatt.c:1016:2: known_value_assign: "last" =3D "65535", its value i=
s now 65535.
attrib/gatt.c:1087:2: overflow_const: Expression "dd->start", which is eq=
ual to 65536, where "last + 1" is known to be equal to 65536, overflows t=
he type that receives it, an unsigned integer 16 bits wide.
1085|		}
1086|
1087|->		dd->start =3D last + 1;
1088|
1089|		if (last < dd->end && !uuid_found) {


  Commit: 1ba9e5f21ca2bd2e60a9fec9f520caf800d56d60
      https://github.com/bluez/bluez/commit/1ba9e5f21ca2bd2e60a9fec9f520c=
af800d56d60
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-10 (Fri, 10 May 2024)

  Changed paths:
    M client/gatt.c

  Log Message:
  -----------
  client/gatt: Don't pass negative fd on error

Error: NEGATIVE_RETURNS (CWE-394): [#def33]
client/gatt.c:973:2: negative_return_fn: Function "io_get_fd(io)" returns=
 a negative number.
client/gatt.c:973:2: negative_returns: "io_get_fd(io)" is passed to a par=
ameter that cannot be negative.
971|	msg.msg_iovlen =3D iovlen;
972|
973|->	ret =3D sendmsg(io_get_fd(io), &msg, MSG_NOSIGNAL);
974|	if (ret < 0) {
975|		ret =3D -errno;

Error: NEGATIVE_RETURNS (CWE-394): [#def34]
client/gatt.c:1049:2: negative_return_fn: Function "io_get_fd(io)" return=
s a negative number.
client/gatt.c:1049:2: assign: Assigning: "fd" =3D "io_get_fd(io)".
client/gatt.c:1062:2: negative_returns: "fd" is passed to a parameter tha=
t cannot be negative.
1060|		msg.msg_iovlen =3D 1;
1061|
1062|->		bytes_read =3D recvmsg(fd, &msg, MSG_DONTWAIT);
1063|		if (bytes_read < 0) {
1064|			bt_shell_printf("recvmsg: %s", strerror(errno));


  Commit: 4262170a7989e63c0a340a7acef4181045930e8d
      https://github.com/bluez/bluez/commit/4262170a7989e63c0a340a7acef41=
81045930e8d
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-10 (Fri, 10 May 2024)

  Changed paths:
    M client/gatt.c

  Log Message:
  -----------
  client/gatt: Check write_value() retval

Error: CHECKED_RETURN (CWE-252): [#def35]
client/gatt.c:3191:3: check_return: Calling "write_value" without checkin=
g return value (as is done elsewhere 5 out of 6 times).
client/gatt.c:2371:2: example_checked: Example 1: "write_value(&chrc->val=
ue_len, &chrc->value, value, value_len, aad->offset, chrc->max_val_len)" =
has its value checked in "write_value(&chrc->value_len, &chrc->value, val=
ue, value_len, aad->offset, chrc->max_val_len)".
client/gatt.c:2502:2: example_checked: Example 2: "write_value(&chrc->val=
ue_len, &chrc->value, value, value_len, offset, chrc->max_val_len)" has i=
ts value checked in "write_value(&chrc->value_len, &chrc->value, value, v=
alue_len, offset, chrc->max_val_len)".
client/gatt.c:2919:2: example_checked: Example 3: "write_value(&desc->val=
ue_len, &desc->value, value, value_len, offset, desc->max_val_len)" has i=
ts value checked in "write_value(&desc->value_len, &desc->value, value, v=
alue_len, offset, desc->max_val_len)".
client/gatt.c:759:3: example_checked: Example 4: "write_value(&c->value_l=
en, &c->value, value, value_len, offset, c->max_val_len)" has its value c=
hecked in "write_value(&c->value_len, &c->value, value, value_len, offset=
, c->max_val_len)".
client/gatt.c:775:3: example_checked: Example 5: "write_value(&d->value_l=
en, &d->value, value, value_len, offset, d->max_val_len)" has its value c=
hecked in "write_value(&d->value_len, &d->value, value, value_len, offset=
, d->max_val_len)".
3189|			}
3190|
3191|->			write_value(&chrc->value_len, &chrc->value, value, len,
3192|					0, chrc->max_val_len);


  Commit: f3f762b77b5898ac0203d00bd64087e2a22e34be
      https://github.com/bluez/bluez/commit/f3f762b77b5898ac0203d00bd6408=
7e2a22e34be
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-10 (Fri, 10 May 2024)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client/main: Fix array access

Error: CPPCHECK_WARNING (CWE-788): [#def36]
client/main.c:833: error[ctuArrayIndex]: Array index out of bounds; 'argv=
' buffer size is 0 and it is accessed at offset 1.
831|	const char **opt;
832|
833|->	if (!strcmp(argv[1], "help")) {
834|		for (opt =3D arg_table; opt && *opt; opt++)
835|			bt_shell_printf("%s\n", *opt);


  Commit: ab325450b0c2b3e9a1b13d81e079d0bcd34e1835
      https://github.com/bluez/bluez/commit/ab325450b0c2b3e9a1b13d81e079d=
0bcd34e1835
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-10 (Fri, 10 May 2024)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client/main: Fix mismatched free

Error: ALLOC_FREE_MISMATCH (CWE-762): [#def37]
client/main.c:2108:2: alloc: Allocation of memory which must be freed usi=
ng "g_free".
client/main.c:2108:2: assign: Assigning: "desc" =3D "g_strdup_printf("\x1=
b[0;94m[%s]\x1b[0m# ", attr)".
client/main.c:2111:2: free: Calling "free" frees "desc" using "free" but =
it should have been freed using "g_free".
2109|
2110|		bt_shell_set_prompt(desc);
2111|->		free(desc);
2112|   }
2113|


  Commit: 0b842fe9b1fef38fa6510a0444817dd241d4ea98
      https://github.com/bluez/bluez/commit/0b842fe9b1fef38fa6510a0444817=
dd241d4ea98
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-10 (Fri, 10 May 2024)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Fix memory leak

name2utf8() returns newly allocated memory which needs to be freed.

Error: RESOURCE_LEAK (CWE-772): [#def27] [important]
monitor/att.c:2291:2: alloc_fn: Storage is returned from allocation funct=
ion "name2utf8".
monitor/att.c:2291:2: var_assign: Assigning: "name" =3D storage returned =
from "name2utf8((uint8_t *)frame->data, frame->size)".
monitor/att.c:2293:2: noescape: Resource "name" is not freed or pointed-t=
o in "printf". [Note: The source code implementation of the function has =
been overridden by a builtin model.]
monitor/att.c:2294:1: leaked_storage: Variable "name" going out of scope =
leaks the storage it points to.
2292|
2293|		print_field("  Media Player Name: %s", name);
2294|-> }
2295|
2296|   static void mp_name_read(const struct l2cap_frame *frame)

Error: RESOURCE_LEAK (CWE-772): [#def28] [important]
monitor/att.c:2320:2: alloc_fn: Storage is returned from allocation funct=
ion "name2utf8".
monitor/att.c:2320:2: var_assign: Assigning: "name" =3D storage returned =
from "name2utf8((uint8_t *)frame->data, frame->size)".
monitor/att.c:2322:2: noescape: Resource "name" is not freed or pointed-t=
o in "printf". [Note: The source code implementation of the function has =
been overridden by a builtin model.]
monitor/att.c:2323:1: leaked_storage: Variable "name" going out of scope =
leaks the storage it points to.
2321|
2322|		print_field("  Track Title: %s", name);
2323|-> }
2324|
2325|   static void track_title_read(const struct l2cap_frame *frame)

Error: RESOURCE_LEAK (CWE-772): [#def29] [important]
monitor/att.c:2453:2: alloc_fn: Storage is returned from allocation funct=
ion "name2utf8".
monitor/att.c:2453:2: var_assign: Assigning: "name" =3D storage returned =
from "name2utf8((uint8_t *)frame->data, frame->size)".
monitor/att.c:2455:2: noescape: Resource "name" is not freed or pointed-t=
o in "printf". [Note: The source code implementation of the function has =
been overridden by a builtin model.]
monitor/att.c:2456:1: leaked_storage: Variable "name" going out of scope =
leaks the storage it points to.
2454|
2455|		print_field("  Bearer Name: %s", name);
2456|-> }
2457|
2458|   static void bearer_name_read(const struct l2cap_frame *frame)

Error: RESOURCE_LEAK (CWE-772): [#def30] [important]
monitor/att.c:2472:2: alloc_fn: Storage is returned from allocation funct=
ion "name2utf8".
monitor/att.c:2472:2: var_assign: Assigning: "name" =3D storage returned =
from "name2utf8((uint8_t *)frame->data, frame->size)".
monitor/att.c:2474:2: noescape: Resource "name" is not freed or pointed-t=
o in "printf". [Note: The source code implementation of the function has =
been overridden by a builtin model.]
monitor/att.c:2475:1: leaked_storage: Variable "name" going out of scope =
leaks the storage it points to.
2473|
2474|		print_field("  Bearer Uci Name: %s", name);
2475|-> }
2476|
2477|   static void print_technology_name(const struct l2cap_frame *frame=
)

Error: RESOURCE_LEAK (CWE-772): [#def31] [important]
monitor/att.c:2541:2: alloc_fn: Storage is returned from allocation funct=
ion "name2utf8".
monitor/att.c:2541:2: var_assign: Assigning: "name" =3D storage returned =
from "name2utf8((uint8_t *)frame->data, frame->size)".
monitor/att.c:2543:2: noescape: Resource "name" is not freed or pointed-t=
o in "printf". [Note: The source code implementation of the function has =
been overridden by a builtin model.]
monitor/att.c:2544:1: leaked_storage: Variable "name" going out of scope =
leaks the storage it points to.
2542|
2543|		print_field("  Uri scheme Name: %s", name);
2544|-> }
2545|
2546|   static void bearer_uri_schemes_list_read(const struct l2cap_frame=
 *frame)

Error: RESOURCE_LEAK (CWE-772): [#def32] [important]
monitor/att.c:2653:2: alloc_fn: Storage is returned from allocation funct=
ion "name2utf8".
monitor/att.c:2653:2: var_assign: Assigning: "call_uri" =3D storage retur=
ned from "name2utf8((uint8_t *)frame->data, frame->size)".
monitor/att.c:2655:2: noescape: Resource "call_uri" is not freed or point=
ed-to in "printf". [Note: The source code implementation of the function =
has been overridden by a builtin model.]
monitor/att.c:2660:1: leaked_storage: Variable "call_uri" going out of sc=
ope leaks the storage it points to.
2658|		if (frame->size)
2659|			print_hex_field("  call_list Data", frame->data, frame->size);
2660|-> }
2661|
2662|   static void bearer_current_call_list_read(const struct l2cap_fram=
e *frame)

Error: RESOURCE_LEAK (CWE-772): [#def33] [important]
monitor/att.c:2741:2: alloc_fn: Storage is returned from allocation funct=
ion "name2utf8".
monitor/att.c:2741:2: var_assign: Assigning: "name" =3D storage returned =
from "name2utf8((uint8_t *)frame->data, frame->size)".
monitor/att.c:2743:2: noescape: Resource "name" is not freed or pointed-t=
o in "printf". [Note: The source code implementation of the function has =
been overridden by a builtin model.]
monitor/att.c:2748:1: leaked_storage: Variable "name" going out of scope =
leaks the storage it points to.
2746|		if (frame->size)
2747|			print_hex_field("  Data", frame->data, frame->size);
2748|-> }
2749|
2750|   static void incom_target_bearer_uri_read(const struct l2cap_frame=
 *frame)

Error: RESOURCE_LEAK (CWE-772): [#def34] [important]
monitor/att.c:2851:3: alloc_fn: Storage is returned from allocation funct=
ion "name2utf8".
monitor/att.c:2851:3: var_assign: Assigning: "name" =3D storage returned =
from "name2utf8((uint8_t *)frame->data, frame->size)".
monitor/att.c:2852:3: noescape: Resource "name" is not freed or pointed-t=
o in "printf". [Note: The source code implementation of the function has =
been overridden by a builtin model.]
monitor/att.c:2871:1: leaked_storage: Variable "name" going out of scope =
leaks the storage it points to.
2869|		if (frame->size)
2870|			print_hex_field("call_cp Data", frame->data, frame->size);
2871|-> }
2872|
2873|   static void print_call_cp_notification(const struct l2cap_frame *=
frame)

Error: RESOURCE_LEAK (CWE-772): [#def35] [important]
monitor/att.c:3046:2: alloc_fn: Storage is returned from allocation funct=
ion "name2utf8".
monitor/att.c:3046:2: var_assign: Assigning: "name" =3D storage returned =
from "name2utf8((uint8_t *)frame->data, frame->size)".
monitor/att.c:3048:2: noescape: Resource "name" is not freed or pointed-t=
o in "printf". [Note: The source code implementation of the function has =
been overridden by a builtin model.]
monitor/att.c:3053:1: leaked_storage: Variable "name" going out of scope =
leaks the storage it points to.
3051|		if (frame->size)
3052|			print_hex_field(" Data", frame->data, frame->size);
3053|-> }
3054|
3055|   static void incoming_call_read(const struct l2cap_frame *frame)

Error: RESOURCE_LEAK (CWE-772): [#def36] [important]
monitor/att.c:3077:2: alloc_fn: Storage is returned from allocation funct=
ion "name2utf8".
monitor/att.c:3077:2: var_assign: Assigning: "name" =3D storage returned =
from "name2utf8((uint8_t *)frame->data, frame->size)".
monitor/att.c:3079:2: noescape: Resource "name" is not freed or pointed-t=
o in "printf". [Note: The source code implementation of the function has =
been overridden by a builtin model.]
monitor/att.c:3084:1: leaked_storage: Variable "name" going out of scope =
leaks the storage it points to.
3082|		if (frame->size)
3083|			print_hex_field(" Data", frame->data, frame->size);
3084|-> }
3085|
3086|   static void call_friendly_name_read(const struct l2cap_frame *fra=
me)


  Commit: d1360727086973f95f4a2eb457354a0b14ae401e
      https://github.com/bluez/bluez/commit/d1360727086973f95f4a2eb457354=
a0b14ae401e
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-10 (Fri, 10 May 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix memory leaks

Error: RESOURCE_LEAK (CWE-772): [#def37] [important]
profiles/audio/bap.c:1064:13: alloc_fn: Storage is returned from allocati=
on function "util_malloc".
profiles/audio/bap.c:1064:13: var_assign: Assigning: "__p" =3D storage re=
turned from "util_malloc(__n * __s)".
profiles/audio/bap.c:1064:13: noescape: Resource "__p" is not freed or po=
inted-to in "memset". [Note: The source code implementation of the functi=
on has been overridden by a builtin model.]
profiles/audio/bap.c:1064:13: leaked_storage: Variable "__p" going out of=
 scope leaks the storage it points to.
profiles/audio/bap.c:1064:3: var_assign: Assigning: "l2_caps" =3D "({...;=
 __p;})".
profiles/audio/bap.c:1066:4: leaked_storage: Variable "l2_caps" going out=
 of scope leaks the storage it points to.
1064|			l2_caps =3D new0(struct iovec, 1);
1065|			if (!util_iov_pull_u8(&iov, (void *)&l2_caps->iov_len))
1066|->				goto fail;
1067|
1068|			util_iov_memcpy(l2_caps, util_iov_pull_mem(&iov,

Error: RESOURCE_LEAK (CWE-772): [#def38] [important]
profiles/audio/bap.c:1064:13: alloc_fn: Storage is returned from allocati=
on function "util_malloc".
profiles/audio/bap.c:1064:13: var_assign: Assigning: "__p" =3D storage re=
turned from "util_malloc(__n * __s)".
profiles/audio/bap.c:1064:13: noescape: Resource "__p" is not freed or po=
inted-to in "memset". [Note: The source code implementation of the functi=
on has been overridden by a builtin model.]
profiles/audio/bap.c:1064:13: leaked_storage: Variable "__p" going out of=
 scope leaks the storage it points to.
profiles/audio/bap.c:1064:3: var_assign: Assigning: "l2_caps" =3D "({...;=
 __p;})".
profiles/audio/bap.c:1068:3: noescape: Resource "l2_caps" is not freed or=
 pointed-to in "util_iov_memcpy".
profiles/audio/bap.c:1080:4: leaked_storage: Variable "l2_caps" going out=
 of scope leaks the storage it points to.
1078|			meta =3D new0(struct iovec, 1);
1079|			if (!util_iov_pull_u8(&iov, (void *)&meta->iov_len))
1080|->				goto fail;
1081|
1082|			util_iov_memcpy(meta,

Error: RESOURCE_LEAK (CWE-772): [#def39] [important]
profiles/audio/bap.c:1078:10: alloc_fn: Storage is returned from allocati=
on function "util_malloc".
profiles/audio/bap.c:1078:10: var_assign: Assigning: "__p" =3D storage re=
turned from "util_malloc(__n * __s)".
profiles/audio/bap.c:1078:10: noescape: Resource "__p" is not freed or po=
inted-to in "memset". [Note: The source code implementation of the functi=
on has been overridden by a builtin model.]
profiles/audio/bap.c:1078:10: leaked_storage: Variable "__p" going out of=
 scope leaks the storage it points to.
profiles/audio/bap.c:1078:3: var_assign: Assigning: "meta" =3D "({...; __=
p;})".
profiles/audio/bap.c:1080:4: leaked_storage: Variable "meta" going out of=
 scope leaks the storage it points to.
1078|			meta =3D new0(struct iovec, 1);
1079|			if (!util_iov_pull_u8(&iov, (void *)&meta->iov_len))
1080|->				goto fail;
1081|
1082|			util_iov_memcpy(meta,

Error: RESOURCE_LEAK (CWE-772): [#def40] [important]
profiles/audio/bap.c:1064:13: alloc_fn: Storage is returned from allocati=
on function "util_malloc".
profiles/audio/bap.c:1064:13: var_assign: Assigning: "__p" =3D storage re=
turned from "util_malloc(__n * __s)".
profiles/audio/bap.c:1064:13: noescape: Resource "__p" is not freed or po=
inted-to in "memset". [Note: The source code implementation of the functi=
on has been overridden by a builtin model.]
profiles/audio/bap.c:1064:13: leaked_storage: Variable "__p" going out of=
 scope leaks the storage it points to.
profiles/audio/bap.c:1064:3: var_assign: Assigning: "l2_caps" =3D "({...;=
 __p;})".
profiles/audio/bap.c:1068:3: noescape: Resource "l2_caps" is not freed or=
 pointed-to in "util_iov_memcpy".
profiles/audio/bap.c:1119:4: noescape: Resource "l2_caps" is not freed or=
 pointed-to in "bt_bap_add_bis".
profiles/audio/bap.c:1119:4: noescape: Resource "l2_caps" is not freed or=
 pointed-to in "bt_bap_add_bis".
profiles/audio/bap.c:1097:5: leaked_storage: Variable "l2_caps" going out=
 of scope leaks the storage it points to.
1095|
1096|				if (!util_iov_pull_u8(&iov, &bis_index))
1097|->					goto fail;
1098|
1099|				util_debug(func, NULL, "BIS #%d", bis_index);

Error: RESOURCE_LEAK (CWE-772): [#def41] [important]
profiles/audio/bap.c:1078:10: alloc_fn: Storage is returned from allocati=
on function "util_malloc".
profiles/audio/bap.c:1078:10: var_assign: Assigning: "__p" =3D storage re=
turned from "util_malloc(__n * __s)".
profiles/audio/bap.c:1078:10: noescape: Resource "__p" is not freed or po=
inted-to in "memset". [Note: The source code implementation of the functi=
on has been overridden by a builtin model.]
profiles/audio/bap.c:1078:10: leaked_storage: Variable "__p" going out of=
 scope leaks the storage it points to.
profiles/audio/bap.c:1078:3: var_assign: Assigning: "meta" =3D "({...; __=
p;})".
profiles/audio/bap.c:1082:3: noescape: Resource "meta" is not freed or po=
inted-to in "util_iov_memcpy".
profiles/audio/bap.c:1119:4: noescape: Resource "meta" is not freed or po=
inted-to in "bt_bap_add_bis".
profiles/audio/bap.c:1119:4: noescape: Resource "meta" is not freed or po=
inted-to in "bt_bap_add_bis".
profiles/audio/bap.c:1097:5: leaked_storage: Variable "meta" going out of=
 scope leaks the storage it points to.
1095|
1096|				if (!util_iov_pull_u8(&iov, &bis_index))
1097|->					goto fail;
1098|
1099|				util_debug(func, NULL, "BIS #%d", bis_index);

Error: RESOURCE_LEAK (CWE-772): [#def42] [important]
profiles/audio/bap.c:1064:13: alloc_fn: Storage is returned from allocati=
on function "util_malloc".
profiles/audio/bap.c:1064:13: var_assign: Assigning: "__p" =3D storage re=
turned from "util_malloc(__n * __s)".
profiles/audio/bap.c:1064:13: noescape: Resource "__p" is not freed or po=
inted-to in "memset". [Note: The source code implementation of the functi=
on has been overridden by a builtin model.]
profiles/audio/bap.c:1064:13: leaked_storage: Variable "__p" going out of=
 scope leaks the storage it points to.
profiles/audio/bap.c:1064:3: var_assign: Assigning: "l2_caps" =3D "({...;=
 __p;})".
profiles/audio/bap.c:1068:3: noescape: Resource "l2_caps" is not freed or=
 pointed-to in "util_iov_memcpy".
profiles/audio/bap.c:1104:5: leaked_storage: Variable "l2_caps" going out=
 of scope leaks the storage it points to.
1102|				l3_caps =3D new0(struct iovec, 1);
1103|				if (!util_iov_pull_u8(&iov, (void *)&l3_caps->iov_len))
1104|->					goto fail;
1105|
1106|				util_iov_memcpy(l3_caps,

Error: RESOURCE_LEAK (CWE-772): [#def43] [important]
profiles/audio/bap.c:1102:14: alloc_fn: Storage is returned from allocati=
on function "util_malloc".
profiles/audio/bap.c:1102:14: var_assign: Assigning: "__p" =3D storage re=
turned from "util_malloc(__n * __s)".
profiles/audio/bap.c:1102:14: noescape: Resource "__p" is not freed or po=
inted-to in "memset". [Note: The source code implementation of the functi=
on has been overridden by a builtin model.]
profiles/audio/bap.c:1102:14: leaked_storage: Variable "__p" going out of=
 scope leaks the storage it points to.
profiles/audio/bap.c:1102:4: var_assign: Assigning: "l3_caps" =3D "({...;=
 __p;})".
profiles/audio/bap.c:1104:5: leaked_storage: Variable "l3_caps" going out=
 of scope leaks the storage it points to.
1102|				l3_caps =3D new0(struct iovec, 1);
1103|				if (!util_iov_pull_u8(&iov, (void *)&l3_caps->iov_len))
1104|->					goto fail;
1105|
1106|				util_iov_memcpy(l3_caps,

Error: RESOURCE_LEAK (CWE-772): [#def44] [important]
profiles/audio/bap.c:1078:10: alloc_fn: Storage is returned from allocati=
on function "util_malloc".
profiles/audio/bap.c:1078:10: var_assign: Assigning: "__p" =3D storage re=
turned from "util_malloc(__n * __s)".
profiles/audio/bap.c:1078:10: noescape: Resource "__p" is not freed or po=
inted-to in "memset". [Note: The source code implementation of the functi=
on has been overridden by a builtin model.]
profiles/audio/bap.c:1078:10: leaked_storage: Variable "__p" going out of=
 scope leaks the storage it points to.
profiles/audio/bap.c:1078:3: var_assign: Assigning: "meta" =3D "({...; __=
p;})".
profiles/audio/bap.c:1082:3: noescape: Resource "meta" is not freed or po=
inted-to in "util_iov_memcpy".
profiles/audio/bap.c:1104:5: leaked_storage: Variable "meta" going out of=
 scope leaks the storage it points to.
1102|				l3_caps =3D new0(struct iovec, 1);
1103|				if (!util_iov_pull_u8(&iov, (void *)&l3_caps->iov_len))
1104|->					goto fail;
1105|
1106|				util_iov_memcpy(l3_caps,

Error: RESOURCE_LEAK (CWE-772): [#def45] [important]
profiles/audio/bap.c:1064:13: alloc_fn: Storage is returned from allocati=
on function "util_malloc".
profiles/audio/bap.c:1064:13: var_assign: Assigning: "__p" =3D storage re=
turned from "util_malloc(__n * __s)".
profiles/audio/bap.c:1064:13: noescape: Resource "__p" is not freed or po=
inted-to in "memset". [Note: The source code implementation of the functi=
on has been overridden by a builtin model.]
profiles/audio/bap.c:1064:13: leaked_storage: Variable "__p" going out of=
 scope leaks the storage it points to.
profiles/audio/bap.c:1064:3: var_assign: Assigning: "l2_caps" =3D "({...;=
 __p;})".
profiles/audio/bap.c:1068:3: noescape: Resource "l2_caps" is not freed or=
 pointed-to in "util_iov_memcpy".
profiles/audio/bap.c:1119:4: noescape: Resource "l2_caps" is not freed or=
 pointed-to in "bt_bap_add_bis".
profiles/audio/bap.c:1119:4: noescape: Resource "l2_caps" is not freed or=
 pointed-to in "bt_bap_add_bis".
profiles/audio/bap.c:1123:2: leaked_storage: Variable "l2_caps" going out=
 of scope leaks the storage it points to.
1121|			}
1122|
1123|->		}
1124|		return true;
1125|

Error: RESOURCE_LEAK (CWE-772): [#def46] [important]
profiles/audio/bap.c:1078:10: alloc_fn: Storage is returned from allocati=
on function "util_malloc".
profiles/audio/bap.c:1078:10: var_assign: Assigning: "__p" =3D storage re=
turned from "util_malloc(__n * __s)".
profiles/audio/bap.c:1078:10: noescape: Resource "__p" is not freed or po=
inted-to in "memset". [Note: The source code implementation of the functi=
on has been overridden by a builtin model.]
profiles/audio/bap.c:1078:10: leaked_storage: Variable "__p" going out of=
 scope leaks the storage it points to.
profiles/audio/bap.c:1078:3: var_assign: Assigning: "meta" =3D "({...; __=
p;})".
profiles/audio/bap.c:1082:3: noescape: Resource "meta" is not freed or po=
inted-to in "util_iov_memcpy".
profiles/audio/bap.c:1119:4: noescape: Resource "meta" is not freed or po=
inted-to in "bt_bap_add_bis".
profiles/audio/bap.c:1119:4: noescape: Resource "meta" is not freed or po=
inted-to in "bt_bap_add_bis".
profiles/audio/bap.c:1123:2: leaked_storage: Variable "meta" going out of=
 scope leaks the storage it points to.
1121|			}
1122|
1123|->		}
1124|		return true;
1125|


  Commit: 3652e98d2bb6fe8d7ba5b66f9cd6403fca3995b7
      https://github.com/bluez/bluez/commit/3652e98d2bb6fe8d7ba5b66f9cd64=
03fca3995b7
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-10 (Fri, 10 May 2024)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: Fix memory leak

Error: RESOURCE_LEAK (CWE-772): [#def47] [important]
profiles/audio/media.c:1278:2: alloc_arg: "asprintf" allocates memory tha=
t is stored into "name". [Note: The source code implementation of the fun=
ction has been overridden by a builtin model.]
profiles/audio/media.c:1291:2: noescape: Resource "name" is not freed or =
pointed-to in "bt_bap_add_vendor_pac".
profiles/audio/media.c:1297:3: leaked_storage: Variable "name" going out =
of scope leaks the storage it points to.
1295|			error("Unable to create PAC");
1296|			free(metadata);
1297|->			return false;
1298|		}
1299|


  Commit: 45d151ec8a0f096170e83b26c0e91d85afaf2d82
      https://github.com/bluez/bluez/commit/45d151ec8a0f096170e83b26c0e91=
d85afaf2d82
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-10 (Fri, 10 May 2024)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main: Fix memory leaks

Error: RESOURCE_LEAK (CWE-772): [#def51] [important]
src/main.c:451:2: alloc_arg: "parse_config_string" allocates memory that =
is stored into "str".
src/main.c:454:2: identity_transfer: Passing "str" as argument 1 to funct=
ion "strtol", which sets "endptr" to that argument.
src/main.c:456:3: noescape: Assuming resource "str" is not freed or point=
ed-to as ellipsis argument to "btd_error".
src/main.c:457:3: leaked_storage: Variable "endptr" going out of scope le=
aks the storage it points to.
src/main.c:457:3: leaked_storage: Variable "str" going out of scope leaks=
 the storage it points to.
455|	if (!endptr || *endptr !=3D '\0') {
456|		error("%s.%s =3D %s is not integer", group, key, str);
457|->		return false;
458|	}
459|

Error: RESOURCE_LEAK (CWE-772): [#def52] [important]
src/main.c:451:2: alloc_arg: "parse_config_string" allocates memory that =
is stored into "str".
src/main.c:454:2: identity_transfer: Passing "str" as argument 1 to funct=
ion "strtol", which sets "endptr" to that argument.
src/main.c:463:3: leaked_storage: Variable "endptr" going out of scope le=
aks the storage it points to.
src/main.c:463:3: leaked_storage: Variable "str" going out of scope leaks=
 the storage it points to.
461|		warn("%s.%s =3D %zu is out of range (< %zu)", group, key, tmp,
462|									min);
463|->		return false;
464|	}
465|

Error: RESOURCE_LEAK (CWE-772): [#def53] [important]
src/main.c:451:2: alloc_arg: "parse_config_string" allocates memory that =
is stored into "str".
src/main.c:454:2: identity_transfer: Passing "str" as argument 1 to funct=
ion "strtol", which sets "endptr" to that argument.
src/main.c:475:2: leaked_storage: Variable "endptr" going out of scope le=
aks the storage it points to.
src/main.c:475:2: leaked_storage: Variable "str" going out of scope leaks=
 the storage it points to.
473|		*val =3D tmp;
474|
475|->	return true;
476|   }
477|


  Commit: d30dc38b042542ddb29ac821300e95dc9e631b61
      https://github.com/bluez/bluez/commit/d30dc38b042542ddb29ac821300e9=
5dc9e631b61
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-10 (Fri, 10 May 2024)

  Changed paths:
    M tools/isotest.c

  Log Message:
  -----------
  isotest: Consider "0" fd to be valid

Error: RESOURCE_LEAK (CWE-772): [#def79] [important]
tools/isotest.c:923:4: open_fn: Returning handle opened by "open_file".
tools/isotest.c:923:4: var_assign: Assigning: "fd" =3D handle returned fr=
om "open_file(altername)".
tools/isotest.c:925:3: off_by_one: Testing whether handle "fd" is strictl=
y greater than zero is suspicious.  "fd" leaks when it is zero.
tools/isotest.c:925:3: remediation: Did you intend to include equality wi=
th zero?
tools/isotest.c:926:4: overwrite_var: Overwriting handle "fd" in "fd =3D =
open_file(filename)" leaks the handle.
924|
925|		if (fd <=3D 0)
926|->			fd =3D open_file(filename);
927|	}
928|


  Commit: 9a36f191aa783ad206460569390d1b7f388d9a66
      https://github.com/bluez/bluez/commit/9a36f191aa783ad206460569390d1=
b7f388d9a66
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-10 (Fri, 10 May 2024)

  Changed paths:
    M tools/isotest.c

  Log Message:
  -----------
  isotest: Fix error check after opening file

Consider "0" to be a valid fd.


  Commit: 6f041df23ecf263ad80e1f3f952cbd67183ec3e6
      https://github.com/bluez/bluez/commit/6f041df23ecf263ad80e1f3f952cb=
d67183ec3e6
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-10 (Fri, 10 May 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Fix copy/paste error

Error: COPY_PASTE_ERROR (CWE-398): [#def95] [important]
client/player.c:1846:6: original: "qos->sync_cte_type" looks like the ori=
ginal copy.
client/player.c:1852:6: copy_paste_error: "sync_cte_type" in "qos->sync_c=
te_type" looks like a copy-paste error.
client/player.c:1852:6: remediation: Should it say "mse" instead?
1850|		}
1851|
1852|->		if (qos->sync_cte_type) {
1853|			bt_shell_printf("MSE %u\n", qos->mse);
1854|			g_dbus_dict_append_entry(iter, "MSE", DBUS_TYPE_BYTE,


  Commit: 856353b254da30741a12d8e2d1d3bce3c10c3de7
      https://github.com/bluez/bluez/commit/856353b254da30741a12d8e2d1d3b=
ce3c10c3de7
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-10 (Fri, 10 May 2024)

  Changed paths:
    M src/shared/vcp.c

  Log Message:
  -----------
  shared/vcp: Fix copy/paste error

Error: COPY_PASTE_ERROR (CWE-398): [#def97] [important]
src/shared/vcp.c:2610:16: original: "aics->gain_stting_prop" looks like t=
he original copy.
src/shared/vcp.c:2625:16: copy_paste_error: "gain_stting_prop" in "aics->=
gain_stting_prop" looks like a copy-paste error.
src/shared/vcp.c:2625:16: remediation: Should it say "aud_ip_type" instea=
d?
2623|
2624|			aics =3D vcp_get_aics(vcp);
2625|->			if (!aics || aics->gain_stting_prop)
2626|				return;
2627|


  Commit: 3e03788ba80c94888d9e78bf1c8f62fff42353b8
      https://github.com/bluez/bluez/commit/3e03788ba80c94888d9e78bf1c8f6=
2fff42353b8
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-10 (Fri, 10 May 2024)

  Changed paths:
    M tools/isotest.c

  Log Message:
  -----------
  isotest: Fix fd leak

Error: RESOURCE_LEAK (CWE-772): [#def65] [important]
tools/isotest.c:923:4: open_fn: Returning handle opened by "open_file".
tools/isotest.c:923:4: var_assign: Assigning: "fd" =3D handle returned fr=
om "open_file(altername)".
tools/isotest.c:953:3: leaked_handle: Handle variable "fd" going out of s=
cope leaks the handle.
951|
952|		free(sk_arr);
953|->		return;
954|	}
955|


  Commit: c81f9320357b0808dd4debebc687d26dc0be30ab
      https://github.com/bluez/bluez/commit/c81f9320357b0808dd4debebc687d=
26dc0be30ab
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-10 (Fri, 10 May 2024)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Fix fd leak

Error: RESOURCE_LEAK (CWE-772): [#def63] [important]
tools/iso-tester.c:1796:2: open_fn: Returning handle opened by "socket".
tools/iso-tester.c:1796:2: var_assign: Assigning: "sk" =3D handle returne=
d from "socket(31, 2053, 8)".
tools/iso-tester.c:1807:3: leaked_handle: Handle variable "sk" going out =
of scope leaks the handle.
1805|		if (!master_bdaddr) {
1806|			tester_warn("No master bdaddr");
1807|->			return -ENODEV;
1808|		}
1809|


  Commit: dc60ce0b460adf6b39c0ea5dbea072e9a50e6ec3
      https://github.com/bluez/bluez/commit/dc60ce0b460adf6b39c0ea5dbea07=
2e9a50e6ec3
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-10 (Fri, 10 May 2024)

  Changed paths:
    M lib/sdp.c

  Log Message:
  -----------
  sdp: Fix use of uninitialised memory

Error: UNINIT (CWE-457): [#def10] [important]
lib/sdp.c:2302:2: alloc_fn: Calling "malloc" which returns uninitialized =
memory.
lib/sdp.c:2302:2: assign: Assigning: "seqDTDs" =3D "malloc(seqlen * 8UL)"=
, which points to uninitialized data.
lib/sdp.c:2355:2: uninit_use_in_call: Using uninitialized value "*seqDTDs=
" when calling "sdp_seq_alloc".
2353|			}
2354|		}
2355|->		seq =3D sdp_seq_alloc(seqDTDs, seqs, seqlen);
2356|		free(seqDTDs);
2357|		free(seqs);


  Commit: e5925dbb84fa306275810016b244f69484c7e92f
      https://github.com/bluez/bluez/commit/e5925dbb84fa306275810016b244f=
69484c7e92f
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-10 (Fri, 10 May 2024)

  Changed paths:
    M monitor/jlink.c

  Log Message:
  -----------
  monitor: Work-around memory leak warning

Work-around this warning by making the so pointer global.

Error: RESOURCE_LEAK (CWE-772): [#def29] [important]
monitor/jlink.c:87:3: alloc_fn: Storage is returned from allocation funct=
ion "dlopen".
monitor/jlink.c:87:3: var_assign: Assigning: "so" =3D storage returned fr=
om "dlopen(jlink_so_name[i], 1)".
monitor/jlink.c:95:2: noescape: Resource "so" is not freed or pointed-to =
in "dlsym".
monitor/jlink.c:96:2: noescape: Resource "so" is not freed or pointed-to =
in "dlsym".
monitor/jlink.c:97:2: noescape: Resource "so" is not freed or pointed-to =
in "dlsym".
monitor/jlink.c:98:2: noescape: Resource "so" is not freed or pointed-to =
in "dlsym".
monitor/jlink.c:99:2: noescape: Resource "so" is not freed or pointed-to =
in "dlsym".
monitor/jlink.c:100:2: noescape: Resource "so" is not freed or pointed-to=
 in "dlsym".
monitor/jlink.c:101:2: noescape: Resource "so" is not freed or pointed-to=
 in "dlsym".
monitor/jlink.c:102:2: noescape: Resource "so" is not freed or pointed-to=
 in "dlsym".
monitor/jlink.c:103:2: noescape: Resource "so" is not freed or pointed-to=
 in "dlsym".
monitor/jlink.c:104:2: noescape: Resource "so" is not freed or pointed-to=
 in "dlsym".
monitor/jlink.c:116:2: leaked_storage: Variable "so" going out of scope l=
eaks the storage it points to.
114|
115|	/* don't dlclose(so) here cause symbols from it are in use now */
116|->	return 0;
117|   }
118|


  Commit: af2634ce0a62e5b1b98db139daf96b54eb8360d1
      https://github.com/bluez/bluez/commit/af2634ce0a62e5b1b98db139daf96=
b54eb8360d1
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-10 (Fri, 10 May 2024)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  avrcp: Fix uninitialised memory usage

Error: UNINIT (CWE-457): [#def35] [important]
profiles/audio/avrcp.c:2550:2: var_decl: Declaring variable "name" withou=
t initializer.
profiles/audio/avrcp.c:2567:2: uninit_use_in_call: Using uninitialized va=
lue "*name" when calling "media_player_create_item".
2565|		mp =3D player->user_data;
2566|
2567|->		item =3D media_player_create_item(mp, name, PLAYER_ITEM_TYPE_AUD=
IO, uid);
2568|		if (item =3D=3D NULL)
2569|			return NULL;

Error: UNINIT (CWE-457): [#def36] [important]
profiles/audio/avrcp.c:2583:2: var_decl: Declaring variable "name" withou=
t initializer.
profiles/audio/avrcp.c:2601:2: uninit_use_in_call: Using uninitialized va=
lue "*name" when calling "media_player_create_folder".
2599|		}
2600|
2601|->		item =3D media_player_create_folder(mp, name, type, uid);
2602|		if (!item)
2603|			return NULL;


  Commit: 1cb5708fe7cf840ed63f6e450c21fc9cb2ce5b4b
      https://github.com/bluez/bluez/commit/1cb5708fe7cf840ed63f6e450c21f=
c9cb2ce5b4b
  Author: Felipe F. Tonello <eu@felipetonello.com>
  Date:   2024-05-10 (Fri, 10 May 2024)

  Changed paths:
    M profiles/gap/gas.c

  Log Message:
  -----------
  profiles/gap: Some code cleanup

Just removing unecessary function and code duplication.


  Commit: a249eb681512141d10b38b06b7eaafd50958d9b9
      https://github.com/bluez/bluez/commit/a249eb681512141d10b38b06b7eaa=
fd50958d9b9
  Author: Felipe F. Tonello <eu@felipetonello.com>
  Date:   2024-05-10 (Fri, 10 May 2024)

  Changed paths:
    M src/adapter.c
    M src/adapter.h

  Log Message:
  -----------
  src/adapter: Added connection parameter load/store functions

It is interesting to let other parts of bluetoothd to access these
functions since there are few different use-cases where this updating
and loading connection parameters can happen.


  Commit: d391bf4cf320743e780faed31b294c44040762c9
      https://github.com/bluez/bluez/commit/d391bf4cf320743e780faed31b294=
c44040762c9
  Author: Felipe F. Tonello <eu@felipetonello.com>
  Date:   2024-05-10 (Fri, 10 May 2024)

  Changed paths:
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  src/device: Added function to set connection parameters

This function allows plugins to set the connection parameters of the
respective btd_device object.

It is useful for GAP Peripheral Preferred Connection Parameters
characteristic for example.


  Commit: d6fe19bccba048a68def9410dff6eb4aa82c6848
      https://github.com/bluez/bluez/commit/d6fe19bccba048a68def9410dff6e=
b4aa82c6848
  Author: Felipe F. Tonello <eu@felipetonello.com>
  Date:   2024-05-10 (Fri, 10 May 2024)

  Changed paths:
    M profiles/gap/gas.c

  Log Message:
  -----------
  profiles/gap: Added support for PPCP characteristic

The Peripheral Preferred Connection Parameters (PPCP) characteristic
contains the preferred connection parameters of a peripheral device.

These parameters are stored in the info file and loaded to Kernel using
MGMT's respective command.


  Commit: 33fdb06e7de57eefcf4a038e596693a235884dcb
      https://github.com/bluez/bluez/commit/33fdb06e7de57eefcf4a038e59669=
3a235884dcb
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-05-13 (Mon, 13 May 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix uninitialized field at BASE generation

Currently in bt_bap_stream_get_base, the pres_delay inside the base
variable is left uninitialized and it is later accessed in
set_base_subgroup, to be compared to each stream presentation delay.

This commit adds a fix by initializing the pres_delay field to the
current stream presentation delay, before later updating it based on
comparison.


  Commit: 969ccb526ba979c7a982f31a63b401bc8160eaad
      https://github.com/bluez/bluez/commit/969ccb526ba979c7a982f31a63b40=
1bc8160eaad
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-05-13 (Mon, 13 May 2024)

  Changed paths:
    M src/shared/lc3.h

  Log Message:
  -----------
  shared/lc3: Add missing LC3_QOS_8_1_2_B define

This adds the missing LC3_QOS_8_1_2_B macro and removes the
duplicate define for LC3_QOS_48_1_2_B.


  Commit: 78bf2ab7bdfd3fbaa6aa436282dc40895f2f2116
      https://github.com/bluez/bluez/commit/78bf2ab7bdfd3fbaa6aa436282dc4=
0895f2f2116
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-05-13 (Mon, 13 May 2024)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Pass test_setup as test define argument

The current test_setup function is only targeted for client test cases
that require service discovery. This commit makes the test define more
generic, by adding the test_setup to the list of parameters, so that
custom setup functions can be provided depending on the test case.


  Commit: ffd538cf7757411805ad06197585e07914dcfa2b
      https://github.com/bluez/bluez/commit/ffd538cf7757411805ad06197585e=
07914dcfa2b
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-05-13 (Mon, 13 May 2024)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Add Broadcast Source SCC tests

4.13.1 Broadcast Source Configures Broadcast Audio Stream (page 172):

    Test Purpose:
    Verify that a Broadcast Source IUT can configure a broadcast Audio
    Stream with information defined by the values in its BASE structure.

    Test Case Configuration:
    BAP/BSRC/SCC/BV-01-C [Config Broadcast, LC3 8_1_1]
    BAP/BSRC/SCC/BV-02-C [Config Broadcast, LC3 8_2_1]
    BAP/BSRC/SCC/BV-03-C [Config Broadcast, LC3 16_1_1]
    BAP/BSRC/SCC/BV-04-C [Config Broadcast, LC3 16_2_1]
    BAP/BSRC/SCC/BV-05-C [Config Broadcast, LC3 24_1_1]
    BAP/BSRC/SCC/BV-06-C [Config Broadcast, LC3 24_2_1]
    BAP/BSRC/SCC/BV-07-C [Config Broadcast, LC3 32_1_1]
    BAP/BSRC/SCC/BV-08-C [Config Broadcast, LC3 32_2_1]
    BAP/BSRC/SCC/BV-09-C [Config Broadcast, LC3 44.1_1_1]
    BAP/BSRC/SCC/BV-10-C [Config Broadcast, LC3 44.1_2_1]
    BAP/BSRC/SCC/BV-11-C [Config Broadcast, LC3 48_1_1]
    BAP/BSRC/SCC/BV-12-C [Config Broadcast, LC3 48_2_1]
    BAP/BSRC/SCC/BV-13-C [Config Broadcast, LC3 48_3_1]
    BAP/BSRC/SCC/BV-14-C [Config Broadcast, LC3 48_4_1]
    BAP/BSRC/SCC/BV-15-C [Config Broadcast, LC3 48_5_1]
    BAP/BSRC/SCC/BV-16-C [Config Broadcast, LC3 48_6_1]
    BAP/BSRC/SCC/BV-17-C [Config Broadcast, LC3 8_1_2]
    BAP/BSRC/SCC/BV-18-C [Config Broadcast, LC3 8_2_2]
    BAP/BSRC/SCC/BV-19-C [Config Broadcast, LC3 16_1_2]
    BAP/BSRC/SCC/BV-20-C [Config Broadcast, LC3 16_2_2]
    BAP/BSRC/SCC/BV-21-C [Config Broadcast, LC3 24_1_2]
    BAP/BSRC/SCC/BV-22-C [Config Broadcast, LC3 24_2_2]
    BAP/BSRC/SCC/BV-23-C [Config Broadcast, LC3 32_1_2]
    BAP/BSRC/SCC/BV-24-C [Config Broadcast, LC3 32_2_2]
    BAP/BSRC/SCC/BV-25-C [Config Broadcast, LC3 44.1_1_2]
    BAP/BSRC/SCC/BV-26-C [Config Broadcast, LC3 44.1_2_2]
    BAP/BSRC/SCC/BV-27-C [Config Broadcast, LC3 48_1_2]
    BAP/BSRC/SCC/BV-28-C [Config Broadcast, LC3 48_2_2]
    BAP/BSRC/SCC/BV-29-C [Config Broadcast, LC3 48_3_2]
    BAP/BSRC/SCC/BV-30-C [Config Broadcast, LC3 48_4_2]
    BAP/BSRC/SCC/BV-31-C [Config Broadcast, LC3 48_5_2]
    BAP/BSRC/SCC/BV-32-C [Config Broadcast, LC3 48_6_2]
    BAP/BSRC/SCC/BV-33-C [Config Broadcast, VS]

    Pass verdict:
    The AdvData field of AUX_SYNC_IND and optionally
    AUX_CHAIN_IND PDUs contains the configured BASE information.

Test Summary
------------
BAP/BSRC/SCC/BV-01-C [Config Broadcast, LC3 8_1_1]   Passed
BAP/BSRC/SCC/BV-02-C [Config Broadcast, LC3 8_2_1]   Passed
BAP/BSRC/SCC/BV-03-C [Config Broadcast, LC3 16_1_1]  Passed
BAP/BSRC/SCC/BV-04-C [Config Broadcast, LC3 16_2_1]  Passed
BAP/BSRC/SCC/BV-05-C [Config Broadcast, LC3 24_1_1]  Passed
BAP/BSRC/SCC/BV-06-C [Config Broadcast, LC3 24_2_1]  Passed
BAP/BSRC/SCC/BV-07-C [Config Broadcast, LC3 32_1_1]  Passed
BAP/BSRC/SCC/BV-08-C [Config Broadcast, LC3 32_2_1]  Passed
BAP/BSRC/SCC/BV-09-C [Config Broadcast, LC3 44.1_1_1] Passed
BAP/BSRC/SCC/BV-09-C [Config Broadcast, LC3 44.1_2_1] Passed
BAP/BSRC/SCC/BV-11-C [Config Broadcast, LC3 48_1_1]  Passed
BAP/BSRC/SCC/BV-12-C [Config Broadcast, LC3 48_2_1]  Passed
BAP/BSRC/SCC/BV-13-C [Config Broadcast, LC3 48_3_1]  Passed
BAP/BSRC/SCC/BV-14-C [Config Broadcast, LC3 48_4_1]  Passed
BAP/BSRC/SCC/BV-15-C [Config Broadcast, LC3 48_5_1]  Passed
BAP/BSRC/SCC/BV-16-C [Config Broadcast, LC3 48_6_1]  Passed
BAP/BSRC/SCC/BV-17-C [Config Broadcast, LC3 8_1_2]   Passed
BAP/BSRC/SCC/BV-18-C [Config Broadcast, LC3 8_2_2]   Passed
BAP/BSRC/SCC/BV-19-C [Config Broadcast, LC3 16_1_2]  Passed
BAP/BSRC/SCC/BV-20-C [Config Broadcast, LC3 16_2_2]  Passed
BAP/BSRC/SCC/BV-21-C [Config Broadcast, LC3 24_1_2]  Passed
BAP/BSRC/SCC/BV-22-C [Config Broadcast, LC3 24_2_2]  Passed
BAP/BSRC/SCC/BV-23-C [Config Broadcast, LC3 32_1_2]  Passed
BAP/BSRC/SCC/BV-24-C [Config Broadcast, LC3 32_2_2]  Passed
BAP/BSRC/SCC/BV-25-C [Config Broadcast, LC3 44.1_1_2] Passed
BAP/BSRC/SCC/BV-26-C [Config Broadcast, LC3 44.1_2_2] Passed
BAP/BSRC/SCC/BV-27-C [Config Broadcast, LC3 48_1_2]  Passed
BAP/BSRC/SCC/BV-28-C [Config Broadcast, LC3 48_2_2]  Passed
BAP/BSRC/SCC/BV-29-C [Config Broadcast, LC3 48_3_2]  Passed
BAP/BSRC/SCC/BV-30-C [Config Broadcast, LC3 48_4_2]  Passed
BAP/BSRC/SCC/BV-31-C [Config Broadcast, LC3 48_5_2]  Passed
BAP/BSRC/SCC/BV-32-C [Config Broadcast, LC3 48_6_2]  Passed
BAP/BSRC/SCC/BV-33-C [Config Broadcast, VS]          Passed


  Commit: 832412f5e36a16b0c73597ef2b76aed80d9cfcfb
      https://github.com/bluez/bluez/commit/832412f5e36a16b0c73597ef2b76a=
ed80d9cfcfb
  Author: Preston Hunt <me@prestonhunt.com>
  Date:   2024-05-13 (Mon, 13 May 2024)

  Changed paths:
    M test/exchange-business-cards
    M test/get-obex-capabilities
    M test/list-folders
    M test/sap_client.py
    M test/simple-player

  Log Message:
  -----------
  test examples: fix python3 errors

These scripts have "#!/usr/bin/env python3" but have python2 syntax in
several places. Fixed by running the "2to3" utility.


  Commit: 24039249854ee027b565753a82ec962e2f3035f8
      https://github.com/bluez/bluez/commit/24039249854ee027b565753a82ec9=
62e2f3035f8
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-05-13 (Mon, 13 May 2024)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  tools: fix using too small buffers in test-runner

Fix compiler warning:

tools/test-runner.c:309:57: error: 'sprintf' may write a terminating nul
  past the end of the destination [-Werror=3Dformat-overflow=3D]


  Commit: e453a336c4043db2cf69232a9b90c442131235af
      https://github.com/bluez/bluez/commit/e453a336c4043db2cf69232a9b90c=
442131235af
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-05-13 (Mon, 13 May 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client: fix ISO send data rate

We are sending data to controller at wrong average rate not equal to
1 packet / SDU interval, if Transport_Latency is not an integer multiple
of SDU_Interval.  The calculation currently may also give zero, so no
data gets sent.

We are sending data in bursts of num ~=3D Transport_Latency/SDU_Interval
packets, in hopes that possibly larger timer interval makes things more
efficient.

Fix the data rate by sending num packets every num*SDU_Interval, so that
the average data rate is correct.

Also fix use of itimerspect.it_value with TFD_TIMER_ABSTIME.  The value
set previously is going to always be in the past in CLOCK_MONOTONIC so
just set it to 1.


  Commit: 450e25991246f3b46178a2b3be99cd4c8f493902
      https://github.com/bluez/bluez/commit/450e25991246f3b46178a2b3be99c=
d4c8f493902
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-05-13 (Mon, 13 May 2024)

  Changed paths:
    M android/hal-audio-sbc.c

  Log Message:
  -----------
  android: Fix build error

This fixes the following building error:

android/hal-audio-sbc.c: In function 'sbc_codec_init':
android/hal-audio-sbc.c:260:34: error: 'calloc' sizes specified with
'sizeof' in the earlier argument and not in the later argument
[-Werror=3Dcalloc-transposed-args]
  260 |         sbc_data =3D calloc(sizeof(struct sbc_data), 1);
      |                                  ^~~~~~


  Commit: c7445d9736947163f0028bae0fd1ae2133bbbdbe
      https://github.com/bluez/bluez/commit/c7445d9736947163f0028bae0fd1a=
e2133bbbdbe
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-05-13 (Mon, 13 May 2024)

  Changed paths:
    M mesh/rpl.c

  Log Message:
  -----------
  mesh: Fix not setting rpl_dir as static

rpl_dir shall be made static to be properly scoped.


  Commit: 263d6f7da564f5bf6c89a2beb3cc0b950252f059
      https://github.com/bluez/bluez/commit/263d6f7da564f5bf6c89a2beb3cc0=
b950252f059
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-05-15 (Wed, 15 May 2024)

  Changed paths:
    M src/shared/ad.c
    M src/shared/ad.h

  Log Message:
  -----------
  shared/ad: Add bt_ad_length

This adds bt_ad_length which can be used to return the current size of
the bt_ad data.


  Commit: ea242fbf860284c13cf17f46c9731b148da4a6ac
      https://github.com/bluez/bluez/commit/ea242fbf860284c13cf17f46c9731=
b148da4a6ac
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-05-15 (Wed, 15 May 2024)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: Detect when EA needs to be used

This attempts to detect when an advertising instance needs to set the
secondary PHY in order to force EA PDUs to be used because its data is
too big for legacy PDUs.


  Commit: a9f80a8195b737beebfe1daba50f77ae0db9ab42
      https://github.com/bluez/bluez/commit/a9f80a8195b737beebfe1daba50f7=
7ae0db9ab42
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-05-15 (Wed, 15 May 2024)

  Changed paths:
    M src/shared/tester.c
    M src/shared/tester.h

  Log Message:
  -----------
  shared/tester: add ability to skip tests unless explicitly selected

Make it possible to skip running a test, and skip running if the test
was not explicitly selected on command line.


  Commit: 975d3b1486946598da69d98ab31de91b2d231ade
      https://github.com/bluez/bluez/commit/975d3b1486946598da69d98ab31de=
91b2d231ade
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-05-15 (Wed, 15 May 2024)

  Changed paths:
    M tools/iso-tester.c
    M tools/l2cap-tester.c
    M tools/sco-tester.c

  Log Message:
  -----------
  tools: disable running TX timestamping tests for now

Disable the TX timestamping related tests for now, as the feature will
need some further work.


  Commit: d9de306a28fecd711d3d2f88bf778f98f2772424
      https://github.com/bluez/bluez/commit/d9de306a28fecd711d3d2f88bf778=
f98f2772424
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-05-15 (Wed, 15 May 2024)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  Revert "mgmt-tester: update for Poll Errqueue experimental fature"

This reverts commit c777c55ab662db4e9853bb08a6e1e6c77b319e09.

The kernel feature needs further work.


Compare: https://github.com/bluez/bluez/compare/78af547e94d9...d9de306a28=
fe

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
