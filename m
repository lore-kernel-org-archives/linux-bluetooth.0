Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72859157E82
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 21:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715894018; cv=none; b=NZEAot+bzvQ2DEXrVb2wvP4fmxexZnZrXUsJe6WBsx0TnYC0joCQ+uEiqsajqFGWg0HTQXu5iz9CQ0pmFrqDLoKzKV7s2xWjnSH23qPH0UDKVIUQ+aU9fHpWKXMSmtMtLLMLMgAukXO15OAq76OlX24xL5pcKnwXRaThJd5tGfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715894018; c=relaxed/simple;
	bh=pc+wueOohjbTd/Adj0KrjrPLGLyoB2SpMDpsCSHwf/Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DUyIIMa4CrEb/o6LvAVKAeflkX+Mpchqkm0NN6GJIE4xCFymDef35A4FcM5wI3dzO+7VhiooWi6mTKoa0wIWFtfJpKZY6F5lgaFvIzT2iTCp/kIGgL+9feGY0vHDQg4v2l/isoXm6kLNWF4np3Za6g9ofWmRAlNUhhx63kkTFpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AM/OTjGV; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AM/OTjGV"
Received: from github.com (hubbernetes-node-55ce082.ac4-iad.github.net [10.52.153.38])
	by smtp.github.com (Postfix) with ESMTPA id 7B70B701158
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 14:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1715894015;
	bh=Lo5bD6M6X9T8u6VaYDmIEc4Whrau7Z1J1Suym7hYxHQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AM/OTjGV0hsNlqq0jNm6zT6+F+BHRjLKD7EeGQNQ8BfmrpL+Fi7bW3oLcgs2yq5+R
	 8Dq549JSWwMgypS48rT+kg/z2ImbRd7DtWN8qVy2Vvka6ZZJuIOZB0efSoKrVfDPP1
	 2n3UjcWA2rlnJTE6e2ldi/Lmgqa7cWaqA6jqo4XY=
Date: Thu, 16 May 2024 14:13:35 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/745f32-c9fe88@github.com>
Subject: [bluez/bluez] 0a1159: shared/ecc: Fix uninitialised variable usage
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 0a1159dc105533e3f07cd252d1fd271967d8f4d6
      https://github.com/bluez/bluez/commit/0a1159dc105533e3f07cd252d1fd271967d8f4d6
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-16 (Thu, 16 May 2024)

  Changed paths:
    M src/shared/ecc.c

  Log Message:
  -----------
  shared/ecc: Fix uninitialised variable usage

Error: UNINIT (CWE-457): [#def41] [important]
src/shared/ecc.c:869:2: var_decl: Declaring variable "pk" without initializer.
src/shared/ecc.c:885:34: uninit_use_in_call: Using uninitialized element of array "pk.x" when calling "ecc_point_is_zero".
883|
884|		ecc_point_mult(&pk, &curve_g, priv, NULL, vli_num_bits(priv));
885|->	} while (ecc_point_is_zero(&pk));
886|
887|	ecc_native2bytes(priv, private_key);

Error: UNINIT (CWE-457): [#def42] [important]
src/shared/ecc.c:869:2: var_decl: Declaring variable "pk" without initializer.
src/shared/ecc.c:885:34: uninit_use_in_call: Using uninitialized element of array "pk.x" when calling "ecc_point_is_zero".
src/shared/ecc.c:885:34: uninit_use_in_call: Using uninitialized element of array "pk.y" when calling "ecc_point_is_zero".
883|
884|		ecc_point_mult(&pk, &curve_g, priv, NULL, vli_num_bits(priv));
885|->	} while (ecc_point_is_zero(&pk));
886|
887|	ecc_native2bytes(priv, private_key);

Error: UNINIT (CWE-457): [#def43] [important]
src/shared/ecc.c:869:2: var_decl: Declaring variable "pk" without initializer.
src/shared/ecc.c:889:2: uninit_use_in_call: Using uninitialized value "*pk.y" when calling "ecc_native2bytes".
887|	ecc_native2bytes(priv, private_key);
888|	ecc_native2bytes(pk.x, public_key);
889|->	ecc_native2bytes(pk.y, &public_key[32]);
890|
891|	return true;


  Commit: 75eda690c4af2bf67b026696f504a11d71582884
      https://github.com/bluez/bluez/commit/75eda690c4af2bf67b026696f504a11d71582884
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-16 (Thu, 16 May 2024)

  Changed paths:
    M src/shared/gatt-client.c

  Log Message:
  -----------
  shared/gatt-client: Fix uninitialised variable usage

Error: UNINIT (CWE-457): [#def44] [important]
src/shared/gatt-client.c:1669:2: var_decl: Declaring variable "value" without initializer.
src/shared/gatt-client.c:1686:2: uninit_use_in_call: Using uninitialized value "value" when calling "bt_gatt_client_write_value".
1684|		}
1685|
1686|->		att_id = bt_gatt_client_write_value(notify_data->client,
1687|							notify_data->chrc->ccc_handle,
1688|							(void *)&value, sizeof(value),


  Commit: c63b7b0d732ef73c7a9d3cdcbbd20fe4ccdd6a87
      https://github.com/bluez/bluez/commit/c63b7b0d732ef73c7a9d3cdcbbd20fe4ccdd6a87
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-16 (Thu, 16 May 2024)

  Changed paths:
    M tools/mesh-cfgclient.c

  Log Message:
  -----------
  tools/mesh-cfgclient: Fix uninitialised variable usage

Error: UNINIT (CWE-457): [#def64] [important]
tools/mesh-cfgclient.c:1992:2: var_decl: Declaring variable "result" without initializer.
tools/mesh-cfgclient.c:2041:3: uninit_use: Using uninitialized value "result". Field "result.last_seen" is uninitialized.
2039|							l_queue_length(devices) + 1);
2040|			dev = l_malloc(sizeof(struct unprov_device));
2041|->			*dev = result;
2042|
2043|		} else if (dev->rssi < result.rssi)

Error: UNINIT (CWE-457): [#def65] [important]
tools/mesh-cfgclient.c:1992:2: var_decl: Declaring variable "result" without initializer.
tools/mesh-cfgclient.c:2044:3: uninit_use: Using uninitialized value "result". Field "result.last_seen" is uninitialized.
2042|
2043|		} else if (dev->rssi < result.rssi)
2044|->			*dev = result;
2045|
2046|		dev->last_seen = time(NULL);


  Commit: 9f4b2d0287ef1d4a70648250aeff0d8aa4f61ccc
      https://github.com/bluez/bluez/commit/9f4b2d0287ef1d4a70648250aeff0d8aa4f61ccc
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-16 (Thu, 16 May 2024)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Remove unused envp

Error: UNINIT (CWE-457): [#def70] [important]
tools/test-runner.c:644:2: var_decl: Declaring variable "envp" without initializer.
tools/test-runner.c:682:3: uninit_use_in_call: Using uninitialized value "*envp" when calling "execve".
680|
681|	if (pid == 0) {
682|->		execve(argv[0], argv, envp);
683|		exit(EXIT_SUCCESS);
684|	}

Error: UNINIT (CWE-457): [#def71] [important]
tools/test-runner.c:701:2: var_decl: Declaring variable "envp" without initializer.
tools/test-runner.c:739:3: uninit_use_in_call: Using uninitialized value "*envp" when calling "execve".
737|
738|	if (pid == 0) {
739|->		execve(argv[0], argv, envp);
740|		exit(EXIT_SUCCESS);
741|	}


  Commit: 0640d99ebfaebe7b455a8bd35fefbb9a93485910
      https://github.com/bluez/bluez/commit/0640d99ebfaebe7b455a8bd35fefbb9a93485910
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-16 (Thu, 16 May 2024)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Fix uninitialised variable usage

Error: UNINIT (CWE-457): [#def72] [important]
tools/test-runner.c:856:2: var_decl: Declaring variable "argv" without initializer.
tools/test-runner.c:945:2: uninit_use: Using uninitialized value "argv[0]".
943|   	envp[pos] = NULL;
944|
945|-> 	printf("Running command %s\n", cmdname ? cmdname : argv[0]);
946|
947|   	pid = fork();


  Commit: 9672cf410f8bf5445df98b221f24c035664fec11
      https://github.com/bluez/bluez/commit/9672cf410f8bf5445df98b221f24c035664fec11
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-16 (Thu, 16 May 2024)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Fix uninitialised variable usage

Error: UNINIT (CWE-457): [#def64] [important]
tools/test-runner.c:701:2: var_decl: Declaring variable "envp" without initializer.
tools/test-runner.c:739:3: uninit_use_in_call: Using uninitialized value "*envp" when calling "execve".
737|
738|	if (pid == 0) {
739|->		execve(argv[0], argv, envp);
740|		exit(EXIT_SUCCESS);
741|	}


  Commit: 52336ad64548edfddf18c20bd1a58b3c07bf5a4b
      https://github.com/bluez/bluez/commit/52336ad64548edfddf18c20bd1a58b3c07bf5a4b
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-16 (Thu, 16 May 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix possible use-after-free

stream_set_state() might call bap_stream_detach() if the stream is in
the process of being detached, causing a use-after-free.

Return false from stream_set_state() if the stream is unsafe to
manipulate (ie. was in the process of being detached and freed).

Error: USE_AFTER_FREE (CWE-416): [#def37] [important]
src/shared/bap.c:2490:2: freed_arg: "stream_set_state" frees "stream".
src/shared/bap.c:2493:2: deref_after_free: Dereferencing freed pointer "stream".
2491|
2492|		/* Sink can autonomously for to Streaming state if io already exits */
2493|->		if (stream->io && stream->ep->dir == BT_BAP_SINK)
2494|			stream_set_state(stream, BT_BAP_STREAM_STATE_STREAMING);
2495|


  Commit: 7a638557049441ec055729055dcfb5fc38c5d06a
      https://github.com/bluez/bluez/commit/7a638557049441ec055729055dcfb5fc38c5d06a
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-16 (Thu, 16 May 2024)

  Changed paths:
    M tools/isotest.c

  Log Message:
  -----------
  isotest: Fix bad free

Error: BAD_FREE (CWE-763): [#def58] [important]
tools/isotest.c:1461:5: address: Taking offset from "strchr(filename, 44)".
tools/isotest.c:1461:5: assign: Assigning: "filename" = "strchr(filename, 44) + 1".
tools/isotest.c:1536:2: incorrect_free: "free" frees incorrect pointer "filename".
1534|
1535|   done:
1536|->		free(filename);
1537|
1538|		syslog(LOG_INFO, "Exit");


  Commit: 566af9c2f5efaa33ebb093efb3a03f83876943ba
      https://github.com/bluez/bluez/commit/566af9c2f5efaa33ebb093efb3a03f83876943ba
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-16 (Thu, 16 May 2024)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Fix fd leak on failure

Error: RESOURCE_LEAK (CWE-772): [#def65] [important]
tools/test-runner.c:877:3: open_fn: Returning handle opened by "attach_proto".
tools/test-runner.c:877:3: var_assign: Assigning: "serial_fd" = handle returned from "attach_proto(node, 0U, basic_flags, extra_flags)".
tools/test-runner.c:955:3: leaked_handle: Handle variable "serial_fd" going out of scope leaks the handle.
953|	if (pid < 0) {
954|		perror("Failed to fork new process");
955|->		return;
956|	}
957|


  Commit: f05e448cf81b6ff0a8c7fc1e3accdb4f436a46e0
      https://github.com/bluez/bluez/commit/f05e448cf81b6ff0a8c7fc1e3accdb4f436a46e0
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-16 (Thu, 16 May 2024)

  Changed paths:
    M tools/isotest.c

  Log Message:
  -----------
  isotest: Fix string size expectations

Verify that the peer is a valid bdaddr (and so has the correct length)
before using it.

Error: STRING_SIZE (CWE-120): [#def54] [important]
tools/isotest.c:1198:26: string_size_argv: "argv" contains strings with unknown size.
tools/isotest.c:1459:4: string_size: Passing string "argv[optind + i]" of unknown size to "send_mode", which expects a string of a particular size.

Error: STRING_SIZE (CWE-120): [#def55] [important]
tools/isotest.c:1198:26: string_size_argv: "argv" contains strings with unknown size.
tools/isotest.c:1476:4: var_assign_var: Assigning: "peer" = "argv[optind + i]". Both are now tainted.
tools/isotest.c:1484:5: string_size: Passing string "peer" of unknown size to "bcast_do_connect_mbis", which expects a string of a particular size.

Error: STRING_SIZE (CWE-120): [#def56] [important]
tools/isotest.c:1198:26: string_size_argv: "argv" contains strings with unknown size.
tools/isotest.c:1476:4: var_assign_var: Assigning: "peer" = "argv[optind + i]". Both are now tainted.
tools/isotest.c:1514:5: string_size: Passing string "argv[optind + i]" of unknown size to "do_connect", which expects a string of a particular size.


  Commit: 49d06560692f4307635a28b627a00d8c81948c48
      https://github.com/bluez/bluez/commit/49d06560692f4307635a28b627a00d8c81948c48
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-16 (Thu, 16 May 2024)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Fix non-nul-terminated string

Error: STRING_NULL (CWE-170): [#def59] [important]
tools/mgmt-tester.c:12670:2: string_null_source: Function "vhci_read_devcd" does not terminate string "buf".
tools/mgmt-tester.c:12677:2: string_null: Passing unterminated string "buf" to "strtok_r", which expects a null-terminated string.
12675|
12676|		/* Verify if all devcoredump header fields are present */
12677|->	line = strtok_r(buf, delim, &saveptr);
12678|		while (strlen(test->expect_dump_data[i])) {
12679|			if (!line || strcmp(line, test->expect_dump_data[i])) {


  Commit: 20a0255b9e5fc40868dae916940601a0eaa64dc8
      https://github.com/bluez/bluez/commit/20a0255b9e5fc40868dae916940601a0eaa64dc8
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-16 (Thu, 16 May 2024)

  Changed paths:
    M gdbus/watch.c

  Log Message:
  -----------
  gdbus: Check sprintf retval

Error: SNYK_CODE_WARNING (CWE-125): [#def63] [important]
gdbus/watch.c:131:11: error[cpp/NegativeIndex]: The value from snprintf,
a standard library function that can return a negative value is used as
an index. A negative array index can lead to reading or writing outside
the bounds of the array. Ensure the value of the index used is within
bounds before use.
129|	int offset;
130|
131|->	offset = snprintf(rule, size, "type='signal'");
132|	sender = data->name ? : data->owner;
133|


  Commit: 377f2ec0721f3ad210060b156f960c46e561e5f9
      https://github.com/bluez/bluez/commit/377f2ec0721f3ad210060b156f960c46e561e5f9
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-16 (Thu, 16 May 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix memory leak in error path

Error: RESOURCE_LEAK (CWE-772): [#def38] [important]
src/shared/bap.c:6066:27: alloc_fn: Storage is returned from allocation function "util_malloc".
src/shared/bap.c:6066:27: var_assign: Assigning: "__p" = storage returned from "util_malloc(__n * __s)".
src/shared/bap.c:6066:27: noescape: Resource "__p" is not freed or pointed-to in "memset". [Note: The source code implementation of the function has been overridden by a builtin model.]
src/shared/bap.c:6066:27: leaked_storage: Variable "__p" going out of scope leaks the storage it points to.
src/shared/bap.c:6066:2: var_assign: Assigning: "base_iov" = "({...; __p;})".
src/shared/bap.c:6070:2: noescape: Resource "base_iov" is not freed or pointed-to in "util_iov_push_le24".
src/shared/bap.c:6071:3: leaked_storage: Variable "base_iov" going out of scope leaks the storage it points to.
6069|
6070|		if (!util_iov_push_le24(base_iov, base->pres_delay))
6071|->		return NULL;
6072|
6073|		if (!util_iov_push_u8(base_iov,

Error: RESOURCE_LEAK (CWE-772): [#def39] [important]
src/shared/bap.c:6066:27: alloc_fn: Storage is returned from allocation function "util_malloc".
src/shared/bap.c:6066:27: var_assign: Assigning: "__p" = storage returned from "util_malloc(__n * __s)".
src/shared/bap.c:6066:27: noescape: Resource "__p" is not freed or pointed-to in "memset". [Note: The source code implementation of the function has been overridden by a builtin model.]
src/shared/bap.c:6066:27: leaked_storage: Variable "__p" going out of scope leaks the storage it points to.
src/shared/bap.c:6066:2: var_assign: Assigning: "base_iov" = "({...; __p;})".
src/shared/bap.c:6070:2: noescape: Resource "base_iov" is not freed or pointed-to in "util_iov_push_le24".
src/shared/bap.c:6073:2: noescape: Resource "base_iov" is not freed or pointed-to in "util_iov_push_u8".
src/shared/bap.c:6075:3: leaked_storage: Variable "base_iov" going out of scope leaks the storage it points to.
6073|		if (!util_iov_push_u8(base_iov,
6074|				queue_length(base->subgroups)))
6075|->			return NULL;
6076|
6077|		queue_foreach(base->subgroups, generate_subgroup_base,


  Commit: c9fe888793e5422845da9ac9a6a3d8d052a46b81
      https://github.com/bluez/bluez/commit/c9fe888793e5422845da9ac9a6a3d8d052a46b81
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-05-16 (Thu, 16 May 2024)

  Changed paths:
    M android/handsfree.c

  Log Message:
  -----------
  android/handsfree: Check sprintf retval

Error: SNYK_CODE_WARNING (CWE-125): [#def62] [important]
android/handsfree.c:1247:15: error[cpp/NegativeIndex]: The value from
sprintf, a standard library function that can return a negative value is
used as an index. A negative array index can lead to reading or writing
outside the bounds of the array. Ensure the value of the index used is
within bounds before use.
1245|			buf = g_malloc(len);
1246|
1247|->			ptr = buf + sprintf(buf, "+CIND:");
1248|
1249|			for (i = 0; i < IND_COUNT; i++) {


Compare: https://github.com/bluez/bluez/compare/745f324de589...c9fe888793e5

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
