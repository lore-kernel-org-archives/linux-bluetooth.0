Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51239C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 May 2022 07:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiESH31 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 May 2022 03:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbiESH3V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 May 2022 03:29:21 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55BFF8B0A8
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 00:29:17 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-O2paVnDYMw2543jAVaEiqA-1; Thu, 19 May 2022 03:29:12 -0400
X-MC-Unique: O2paVnDYMw2543jAVaEiqA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95755101A52C;
        Thu, 19 May 2022 07:29:12 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.64.242.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3256D1410DD5;
        Thu, 19 May 2022 07:29:07 +0000 (UTC)
From:   Gopal Tiwari <gopalkrishna.tiwari@gmail.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
        gtiwari@redhat.com
Subject: [BlueZ] Coverity scan results for bluez-5.64
Date:   Thu, 19 May 2022 12:59:03 +0530
Message-Id: <20220519072903.117197-1-gopalkrishna.tiwari@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Gopal Tiwari <gtiwari@redhat.com>

Hi Team/Luiz,

Red Hat is using the Coverity scan tool to perform static analysis of the package which  has a set of supported static analyzers including Coverity Analysis. Following are the results performed over the package bluez-5.64. Let us know your view on the following results. 

Task #252303 - bluez-5.64-1.el9/scan-results-imp.err

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/client/gatt.c:1521: alloc_fn: Storage is returned from allocation function "g_malloc0_n".
bluez-5.64/client/gatt.c:1521: var_assign: Assigning: "__p" = storage returned from "g_malloc0_n(__n, __s)".
bluez-5.64/client/gatt.c:1521: leaked_storage: Variable "__p" going out of scope leaks the storage it points to.
bluez-5.64/client/gatt.c:1521: var_assign: Assigning: "service" = "({...; __p;})".
bluez-5.64/client/gatt.c:1531: leaked_storage: Variable "service" going out of scope leaks the storage it points to.
# 1529|   		service->handle = parse_handle(argv[2]);
# 1530|   		if (!service->handle)
# 1531|-> 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
# 1532|   	}
# 1533|   

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/client/gatt.c:2615: alloc_fn: Storage is returned from allocation function "g_malloc0_n".
bluez-5.64/client/gatt.c:2615: var_assign: Assigning: "__p" = storage returned from "g_malloc0_n(__n, __s)".
bluez-5.64/client/gatt.c:2615: leaked_storage: Variable "__p" going out of scope leaks the storage it points to.
bluez-5.64/client/gatt.c:2615: var_assign: Assigning: "chrc" = "({...; __p;})".
bluez-5.64/client/gatt.c:2626: leaked_storage: Variable "chrc" going out of scope leaks the storage it points to.
# 2624|   		chrc->handle = parse_handle(argv[3]);
# 2625|   		if (!chrc->handle)
# 2626|-> 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
# 2627|   	}
# 2628|   

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/client/gatt.c:2896: alloc_fn: Storage is returned from allocation function "g_malloc0_n".
bluez-5.64/client/gatt.c:2896: var_assign: Assigning: "__p" = storage returned from "g_malloc0_n(__n, __s)".
bluez-5.64/client/gatt.c:2896: leaked_storage: Variable "__p" going out of scope leaks the storage it points to.
bluez-5.64/client/gatt.c:2896: var_assign: Assigning: "desc" = "({...; __p;})".
bluez-5.64/client/gatt.c:2906: leaked_storage: Variable "desc" going out of scope leaks the storage it points to.
# 2904|   		desc->handle = parse_handle(argv[3]);
# 2905|   		if (!desc->handle)
# 2906|-> 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
# 2907|   	}
# 2908|   

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/ell/cert-crypto.c:220: alloc_fn: Storage is returned from allocation function "l_utf8_to_ucs2be".
bluez-5.64/ell/cert-crypto.c:220: var_assign: Assigning: "bmpstring" = storage returned from "l_utf8_to_ucs2be(password, &passwd_len)".
bluez-5.64/ell/cert-crypto.c:264: leaked_storage: Variable "bmpstring" going out of scope leaks the storage it points to.
#  262|   				l_checksum_free(h);
#  263|   				l_free(key);
#  264|-> 				return NULL;
#  265|   			}
#  266|   

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/ell/cert-crypto.c:220: alloc_fn: Storage is returned from allocation function "l_utf8_to_ucs2be".
bluez-5.64/ell/cert-crypto.c:220: var_assign: Assigning: "bmpstring" = storage returned from "l_utf8_to_ucs2be(password, &passwd_len)".
bluez-5.64/ell/cert-crypto.c:306: leaked_storage: Variable "bmpstring" going out of scope leaks the storage it points to.
#  304|   	explicit_bzero(di, sizeof(di));
#  305|   	l_checksum_free(h);
#  306|-> 	return key;
#  307|   }
#  308|   

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/ell/pem.c:205: alloc_arg: "pem_next" allocates memory that is stored into "label".
bluez-5.64/ell/pem.c:208: leaked_storage: Variable "label" going out of scope leaks the storage it points to.
#  206|   				out_endp, false);
#  207|   	if (!base64)
#  208|-> 		return NULL;
#  209|   
#  210|   	if (memchr(base64, ':', base64_len)) {

Error: USE_AFTER_FREE (CWE-416):
bluez-5.64/gobex/gobex-transfer.c:53: freed_arg: "g_obex_cancel_req" frees "transfer->obex".
bluez-5.64/gobex/gobex-transfer.c:56: deref_arg: Calling "g_obex_remove_request_function" dereferences freed pointer "transfer->obex".
#   54|   
#   55|   	if (transfer->put_id > 0)
#   56|-> 		g_obex_remove_request_function(transfer->obex,
#   57|   							transfer->put_id);
#   58|   

Error: USE_AFTER_FREE (CWE-416):
bluez-5.64/gobex/gobex-transfer.c:53: freed_arg: "g_obex_cancel_req" frees "transfer->obex".
bluez-5.64/gobex/gobex-transfer.c:60: deref_arg: Calling "g_obex_remove_request_function" dereferences freed pointer "transfer->obex".
#   58|   
#   59|   	if (transfer->get_id > 0)
#   60|-> 		g_obex_remove_request_function(transfer->obex,
#   61|   							transfer->get_id);
#   62|   

Error: USE_AFTER_FREE (CWE-416):
bluez-5.64/gobex/gobex-transfer.c:53: freed_arg: "g_obex_cancel_req" frees "transfer->obex".
bluez-5.64/gobex/gobex-transfer.c:64: deref_arg: Calling "g_obex_remove_request_function" dereferences freed pointer "transfer->obex".
#   62|   
#   63|   	if (transfer->abort_id > 0)
#   64|-> 		g_obex_remove_request_function(transfer->obex,
#   65|   							transfer->abort_id);
#   66|   

Error: USE_AFTER_FREE (CWE-416):
bluez-5.64/gobex/gobex-transfer.c:53: freed_arg: "g_obex_cancel_req" frees "transfer->obex".
bluez-5.64/gobex/gobex-transfer.c:67: deref_arg: Calling "g_obex_unref" dereferences freed pointer "transfer->obex".
#   65|   							transfer->abort_id);
#   66|   
#   67|-> 	g_obex_unref(transfer->obex);
#   68|   	g_free(transfer);
#   69|   }

Error: USE_AFTER_FREE (CWE-416):
bluez-5.64/gobex/gobex-transfer.c:53: freed_arg: "g_obex_cancel_req" frees "transfer->obex".
bluez-5.64/gobex/gobex-transfer.c:67: pass_freed_arg: Passing freed pointer "transfer->obex" as an argument to "g_obex_unref".
#   65|   							transfer->abort_id);
#   66|   
#   67|-> 	g_obex_unref(transfer->obex);
#   68|   	g_free(transfer);
#   69|   }

Error: USE_AFTER_FREE (CWE-416):
bluez-5.64/gobex/gobex-transfer.c:421: freed_arg: "transfer_put_req_first" frees "transfer".
bluez-5.64/gobex/gobex-transfer.c:423: pass_freed_arg: Passing freed pointer "transfer" as an argument to "g_slist_find".
#  421|   	transfer_put_req_first(transfer, req, first_hdr_id, args);
#  422|   	va_end(args);
#  423|-> 	if (!g_slist_find(transfers, transfer))
#  424|   		return 0;
#  425|   

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/lib/sdp.c:540: alloc_fn: Storage is returned from allocation function "sdp_data_alloc".
bluez-5.64/lib/sdp.c:540: var_assign: Assigning: "data" = storage returned from "sdp_data_alloc(dtd, values[i])".
bluez-5.64/lib/sdp.c:548: var_assign: Assigning: "seq" = "data".
bluez-5.64/lib/sdp.c:550: var_assign: Assigning: "curr" = "data".
bluez-5.64/lib/sdp.c:551: leaked_storage: Variable "data" going out of scope leaks the storage it points to.
bluez-5.64/lib/sdp.c:543: leaked_storage: Variable "seq" going out of scope leaks the storage it points to.
bluez-5.64/lib/sdp.c:543: leaked_storage: Variable "curr" going out of scope leaks the storage it points to.
#  541|   
#  542|   		if (!data)
#  543|-> 			return NULL;
#  544|   
#  545|   		if (curr)

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/lib/sdp.c:4586: alloc_fn: Storage is returned from allocation function "sdp_list_append".
bluez-5.64/lib/sdp.c:4586: var_assign: Assigning: "rec_list" = storage returned from "sdp_list_append(rec_list, rec)".
bluez-5.64/lib/sdp.c:4586: noescape: Resource "rec_list" is not freed or pointed-to in "sdp_list_append".
bluez-5.64/lib/sdp.c:4586: overwrite_var: Overwriting "rec_list" in "rec_list = sdp_list_append(rec_list, rec)" leaks the storage that "rec_list" points to.
# 4584|   				SDPDBG("Bytes scanned : %d", scanned);
# 4585|   				SDPDBG("Attrlist byte count : %d", attr_list_len);
# 4586|-> 				rec_list = sdp_list_append(rec_list, rec);
# 4587|   			} while (scanned < attr_list_len && pdata_len > 0);
# 4588|   

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/lib/sdp.c:4605: alloc_arg: "hci_inquiry" allocates memory that is stored into "ii".
bluez-5.64/lib/sdp.c:4611: leaked_storage: Returning without freeing "ii" leaks the storage that it points to.
# 4609|   	}
# 4610|   	*found = n;
# 4611|-> 	return 0;
# 4612|   }
# 4613|   

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/lib/sdp.c:4919: alloc_fn: Storage is returned from allocation function "sdp_list_append".
bluez-5.64/lib/sdp.c:4919: var_assign: Assigning: "tseq" = storage returned from "sdp_list_append(tseq, subseq)".
bluez-5.64/lib/sdp.c:4919: noescape: Resource "tseq" is not freed or pointed-to in "sdp_list_append".
bluez-5.64/lib/sdp.c:4919: overwrite_var: Overwriting "tseq" in "tseq = sdp_list_append(tseq, subseq)" leaks the storage that "tseq" points to.
# 4917|   				subseq = sdp_list_append(subseq, data);
# 4918|   		}
# 4919|-> 		tseq = sdp_list_append(tseq, subseq);
# 4920|   	}
# 4921|   	*seqp = tseq;

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/mesh/appkey.c:135: alloc_fn: Storage is returned from allocation function "app_key_new".
bluez-5.64/mesh/appkey.c:135: var_assign: Assigning: "key" = storage returned from "app_key_new()".
bluez-5.64/mesh/appkey.c:142: noescape: Resource "key" is not freed or pointed-to in "set_key".
bluez-5.64/mesh/appkey.c:143: leaked_storage: Variable "key" going out of scope leaks the storage it points to.
#  141|   
#  142|   	if (key_value && !set_key(key, app_idx, key_value, false))
#  143|-> 		return false;
#  144|   
#  145|   	if (new_key_value && !set_key(key, app_idx, new_key_value, true))

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/mesh/appkey.c:135: alloc_fn: Storage is returned from allocation function "app_key_new".
bluez-5.64/mesh/appkey.c:135: var_assign: Assigning: "key" = storage returned from "app_key_new()".
bluez-5.64/mesh/appkey.c:145: noescape: Resource "key" is not freed or pointed-to in "set_key".
bluez-5.64/mesh/appkey.c:146: leaked_storage: Variable "key" going out of scope leaks the storage it points to.
#  144|   
#  145|   	if (new_key_value && !set_key(key, app_idx, new_key_value, true))
#  146|-> 		return false;
#  147|   
#  148|   	l_queue_push_tail(app_keys, key);

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/monitor/jlink.c:87: alloc_fn: Storage is returned from allocation function "dlopen".
bluez-5.64/monitor/jlink.c:87: var_assign: Assigning: "so" = storage returned from "dlopen(jlink_so_name[i], 1)".
bluez-5.64/monitor/jlink.c:95: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.64/monitor/jlink.c:96: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.64/monitor/jlink.c:97: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.64/monitor/jlink.c:98: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.64/monitor/jlink.c:99: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.64/monitor/jlink.c:100: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.64/monitor/jlink.c:101: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.64/monitor/jlink.c:102: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.64/monitor/jlink.c:103: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.64/monitor/jlink.c:104: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.64/monitor/jlink.c:111: leaked_storage: Variable "so" going out of scope leaks the storage it points to.
#  109|   			!jlink.emu_getproductname ||
#  110|   			!jlink.rtterminal_control || !jlink.rtterminal_read)
#  111|-> 		return -EIO;
#  112|   
#  113|   	return 0;

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/monitor/jlink.c:87: alloc_fn: Storage is returned from allocation function "dlopen".
bluez-5.64/monitor/jlink.c:87: var_assign: Assigning: "so" = storage returned from "dlopen(jlink_so_name[i], 1)".
bluez-5.64/monitor/jlink.c:95: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.64/monitor/jlink.c:96: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.64/monitor/jlink.c:97: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.64/monitor/jlink.c:98: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.64/monitor/jlink.c:99: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.64/monitor/jlink.c:100: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.64/monitor/jlink.c:101: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.64/monitor/jlink.c:102: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.64/monitor/jlink.c:103: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.64/monitor/jlink.c:104: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.64/monitor/jlink.c:113: leaked_storage: Variable "so" going out of scope leaks the storage it points to.
#  111|   		return -EIO;
#  112|   
#  113|-> 	return 0;
#  114|   }
#  115|   

Error: USE_AFTER_FREE (CWE-416):
bluez-5.64/obexd/client/manager.c:50: freed_arg: "obc_session_shutdown" frees "session".
bluez-5.64/obexd/client/manager.c:51: deref_arg: Calling "obc_session_unref" dereferences freed pointer "session".
#   49|   {
#   50|   	obc_session_shutdown(session);
#   51|-> 	obc_session_unref(session);
#   52|   }
#   53|   

Error: USE_AFTER_FREE (CWE-416):
bluez-5.64/obexd/client/manager.c:50: freed_arg: "obc_session_shutdown" frees "session".
bluez-5.64/obexd/client/manager.c:51: pass_freed_arg: Passing freed pointer "session" as an argument to "obc_session_unref".
#   49|   {
#   50|   	obc_session_shutdown(session);
#   51|-> 	obc_session_unref(session);
#   52|   }
#   53|   

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/obexd/client/map.c:369: alloc_fn: Storage is returned from allocation function "parse_offset".
bluez-5.64/obexd/client/map.c:369: leaked_storage: Failing to save or free storage allocated by "parse_offset(apparam, &value)" leaks it.
#  367|   
#  368|   		if (strcasecmp(key, "Offset") == 0) {
#  369|-> 			if (parse_offset(apparam, &value) == NULL)
#  370|   				return NULL;
#  371|   		} else if (strcasecmp(key, "MaxCount") == 0) {

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/obexd/client/map.c:372: alloc_fn: Storage is returned from allocation function "parse_max_count".
bluez-5.64/obexd/client/map.c:372: leaked_storage: Failing to save or free storage allocated by "parse_max_count(apparam, &value)" leaks it.
#  370|   				return NULL;
#  371|   		} else if (strcasecmp(key, "MaxCount") == 0) {
#  372|-> 			if (parse_max_count(apparam, &value) == NULL)
#  373|   				return NULL;
#  374|   		}

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/obexd/client/map.c:1478: alloc_fn: Storage is returned from allocation function "parse_offset".
bluez-5.64/obexd/client/map.c:1478: leaked_storage: Failing to save or free storage allocated by "parse_offset(apparam, &value)" leaks it.
# 1476|   
# 1477|   		if (strcasecmp(key, "Offset") == 0) {
# 1478|-> 			if (parse_offset(apparam, &value) == NULL)
# 1479|   				return NULL;
# 1480|   		} else if (strcasecmp(key, "MaxCount") == 0) {

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/obexd/client/map.c:1481: alloc_fn: Storage is returned from allocation function "parse_max_count".
bluez-5.64/obexd/client/map.c:1481: leaked_storage: Failing to save or free storage allocated by "parse_max_count(apparam, &value)" leaks it.
# 1479|   				return NULL;
# 1480|   		} else if (strcasecmp(key, "MaxCount") == 0) {
# 1481|-> 			if (parse_max_count(apparam, &value) == NULL)
# 1482|   				return NULL;
# 1483|   		} else if (strcasecmp(key, "SubjectLength") == 0) {

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/obexd/client/map.c:1484: alloc_fn: Storage is returned from allocation function "parse_subject_length".
bluez-5.64/obexd/client/map.c:1484: leaked_storage: Failing to save or free storage allocated by "parse_subject_length(apparam, &value)" leaks it.
# 1482|   				return NULL;
# 1483|   		} else if (strcasecmp(key, "SubjectLength") == 0) {
# 1484|-> 			if (parse_subject_length(apparam, &value) == NULL)
# 1485|   				return NULL;
# 1486|   		} else if (strcasecmp(key, "Fields") == 0) {

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/obexd/client/map.c:1487: alloc_fn: Storage is returned from allocation function "parse_fields".
bluez-5.64/obexd/client/map.c:1487: leaked_storage: Failing to save or free storage allocated by "parse_fields(apparam, &value)" leaks it.
# 1485|   				return NULL;
# 1486|   		} else if (strcasecmp(key, "Fields") == 0) {
# 1487|-> 			if (parse_fields(apparam, &value) == NULL)
# 1488|   				return NULL;
# 1489|   		} else if (strcasecmp(key, "Types") == 0) {

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/obexd/client/map.c:1490: alloc_fn: Storage is returned from allocation function "parse_filter_type".
bluez-5.64/obexd/client/map.c:1490: leaked_storage: Failing to save or free storage allocated by "parse_filter_type(apparam, &value)" leaks it.
# 1488|   				return NULL;
# 1489|   		} else if (strcasecmp(key, "Types") == 0) {
# 1490|-> 			if (parse_filter_type(apparam, &value) == NULL)
# 1491|   				return NULL;
# 1492|   		} else if (strcasecmp(key, "PeriodBegin") == 0) {

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/obexd/client/map.c:1493: alloc_fn: Storage is returned from allocation function "parse_period_begin".
bluez-5.64/obexd/client/map.c:1493: leaked_storage: Failing to save or free storage allocated by "parse_period_begin(apparam, &value)" leaks it.
# 1491|   				return NULL;
# 1492|   		} else if (strcasecmp(key, "PeriodBegin") == 0) {
# 1493|-> 			if (parse_period_begin(apparam, &value) == NULL)
# 1494|   				return NULL;
# 1495|   		} else if (strcasecmp(key, "PeriodEnd") == 0) {

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/obexd/client/map.c:1496: alloc_fn: Storage is returned from allocation function "parse_period_end".
bluez-5.64/obexd/client/map.c:1496: leaked_storage: Failing to save or free storage allocated by "parse_period_end(apparam, &value)" leaks it.
# 1494|   				return NULL;
# 1495|   		} else if (strcasecmp(key, "PeriodEnd") == 0) {
# 1496|-> 			if (parse_period_end(apparam, &value) == NULL)
# 1497|   				return NULL;
# 1498|   		} else if (strcasecmp(key, "Read") == 0) {

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/obexd/client/map.c:1499: alloc_fn: Storage is returned from allocation function "parse_filter_read".
bluez-5.64/obexd/client/map.c:1499: leaked_storage: Failing to save or free storage allocated by "parse_filter_read(apparam, &value)" leaks it.
# 1497|   				return NULL;
# 1498|   		} else if (strcasecmp(key, "Read") == 0) {
# 1499|-> 			if (parse_filter_read(apparam, &value) == NULL)
# 1500|   				return NULL;
# 1501|   		} else if (strcasecmp(key, "Recipient") == 0) {

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/obexd/client/map.c:1502: alloc_fn: Storage is returned from allocation function "parse_filter_recipient".
bluez-5.64/obexd/client/map.c:1502: leaked_storage: Failing to save or free storage allocated by "parse_filter_recipient(apparam, &value)" leaks it.
# 1500|   				return NULL;
# 1501|   		} else if (strcasecmp(key, "Recipient") == 0) {
# 1502|-> 			if (parse_filter_recipient(apparam, &value) == NULL)
# 1503|   				return NULL;
# 1504|   		} else if (strcasecmp(key, "Sender") == 0) {

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/obexd/client/map.c:1505: alloc_fn: Storage is returned from allocation function "parse_filter_sender".
bluez-5.64/obexd/client/map.c:1505: leaked_storage: Failing to save or free storage allocated by "parse_filter_sender(apparam, &value)" leaks it.
# 1503|   				return NULL;
# 1504|   		} else if (strcasecmp(key, "Sender") == 0) {
# 1505|-> 			if (parse_filter_sender(apparam, &value) == NULL)
# 1506|   				return NULL;
# 1507|   		} else if (strcasecmp(key, "Priority") == 0) {

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/obexd/client/map.c:1508: alloc_fn: Storage is returned from allocation function "parse_filter_priority".
bluez-5.64/obexd/client/map.c:1508: leaked_storage: Failing to save or free storage allocated by "parse_filter_priority(apparam, &value)" leaks it.
# 1506|   				return NULL;
# 1507|   		} else if (strcasecmp(key, "Priority") == 0) {
# 1508|-> 			if (parse_filter_priority(apparam, &value) == NULL)
# 1509|   				return NULL;
# 1510|   		}

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/obexd/client/map.c:1740: alloc_fn: Storage is returned from allocation function "parse_transparent".
bluez-5.64/obexd/client/map.c:1740: leaked_storage: Failing to save or free storage allocated by "parse_transparent(apparam, &value)" leaks it.
# 1738|   
# 1739|   		if (strcasecmp(key, "Transparent") == 0) {
# 1740|-> 			if (parse_transparent(apparam, &value) == NULL)
# 1741|   				return NULL;
# 1742|   		} else if (strcasecmp(key, "Retry") == 0) {

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/obexd/client/map.c:1743: alloc_fn: Storage is returned from allocation function "parse_retry".
bluez-5.64/obexd/client/map.c:1743: leaked_storage: Failing to save or free storage allocated by "parse_retry(apparam, &value)" leaks it.
# 1741|   				return NULL;
# 1742|   		} else if (strcasecmp(key, "Retry") == 0) {
# 1743|-> 			if (parse_retry(apparam, &value) == NULL)
# 1744|   				return NULL;
# 1745|   		} else if (strcasecmp(key, "Charset") == 0) {

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/obexd/client/map.c:1746: alloc_fn: Storage is returned from allocation function "parse_charset".
bluez-5.64/obexd/client/map.c:1746: leaked_storage: Failing to save or free storage allocated by "parse_charset(apparam, &value)" leaks it.
# 1744|   				return NULL;
# 1745|   		} else if (strcasecmp(key, "Charset") == 0) {
# 1746|-> 			if (parse_charset(apparam, &value) == NULL)
# 1747|   				return NULL;
# 1748|   		}

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/obexd/client/pbap.c:588: alloc_fn: Storage is returned from allocation function "parse_format".
bluez-5.64/obexd/client/pbap.c:588: leaked_storage: Failing to save or free storage allocated by "parse_format(apparam, &value)" leaks it.
#  586|   
#  587|   		if (strcasecmp(key, "Format") == 0) {
#  588|-> 			if (parse_format(apparam, &value) == NULL)
#  589|   				return NULL;
#  590|   		} else if (strcasecmp(key, "Order") == 0) {

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/obexd/client/pbap.c:591: alloc_fn: Storage is returned from allocation function "parse_order".
bluez-5.64/obexd/client/pbap.c:591: leaked_storage: Failing to save or free storage allocated by "parse_order(apparam, &value)" leaks it.
#  589|   				return NULL;
#  590|   		} else if (strcasecmp(key, "Order") == 0) {
#  591|-> 			if (parse_order(apparam, &value) == NULL)
#  592|   				return NULL;
#  593|   		} else if (strcasecmp(key, "Offset") == 0) {

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/obexd/client/pbap.c:594: alloc_fn: Storage is returned from allocation function "parse_offset".
bluez-5.64/obexd/client/pbap.c:594: leaked_storage: Failing to save or free storage allocated by "parse_offset(apparam, &value)" leaks it.
#  592|   				return NULL;
#  593|   		} else if (strcasecmp(key, "Offset") == 0) {
#  594|-> 			if (parse_offset(apparam, &value) == NULL)
#  595|   				return NULL;
#  596|   		} else if (strcasecmp(key, "MaxCount") == 0) {

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/obexd/client/pbap.c:597: alloc_fn: Storage is returned from allocation function "parse_max_count".
bluez-5.64/obexd/client/pbap.c:597: leaked_storage: Failing to save or free storage allocated by "parse_max_count(apparam, &value)" leaks it.
#  595|   				return NULL;
#  596|   		} else if (strcasecmp(key, "MaxCount") == 0) {
#  597|-> 			if (parse_max_count(apparam, &value) == NULL)
#  598|   				return NULL;
#  599|   		} else if (strcasecmp(key, "Fields") == 0) {

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/obexd/client/pbap.c:600: alloc_fn: Storage is returned from allocation function "parse_fields".
bluez-5.64/obexd/client/pbap.c:600: leaked_storage: Failing to save or free storage allocated by "parse_fields(apparam, &value)" leaks it.
#  598|   				return NULL;
#  599|   		} else if (strcasecmp(key, "Fields") == 0) {
#  600|-> 			if (parse_fields(apparam, &value) == NULL)
#  601|   				return NULL;
#  602|   		}

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/obexd/client/pbap.c:923: alloc_fn: Storage is returned from allocation function "parse_attribute".
bluez-5.64/obexd/client/pbap.c:923: var_assign: Assigning: "apparam" = storage returned from "parse_attribute(NULL, field)".
bluez-5.64/obexd/client/pbap.c:929: leaked_storage: Variable "apparam" going out of scope leaks the storage it points to.
#  927|   
#  928|   	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_STRING)
#  929|-> 		return g_dbus_create_error(message,
#  930|   				ERROR_INTERFACE ".InvalidArguments", NULL);
#  931|   

Error: USE_AFTER_FREE (CWE-416):
bluez-5.64/obexd/client/session.c:926: freed_arg: "session_process_queue" frees "session".
bluez-5.64/obexd/client/session.c:928: deref_arg: Calling "obc_session_unref" dereferences freed pointer "session".
#  926|   		session_process_queue(session);
#  927|   
#  928|-> 	obc_session_unref(session);
#  929|   }
#  930|   

Error: USE_AFTER_FREE (CWE-416):
bluez-5.64/obexd/client/session.c:926: freed_arg: "session_process_queue" frees "session".
bluez-5.64/obexd/client/session.c:928: pass_freed_arg: Passing freed pointer "session" as an argument to "obc_session_unref".
#  926|   		session_process_queue(session);
#  927|   
#  928|-> 	obc_session_unref(session);
#  929|   }
#  930|   

Error: USE_AFTER_FREE (CWE-416):
bluez-5.64/obexd/client/transfer.c:411: freed_arg: "g_obex_cancel_req" frees "transfer->obex".
bluez-5.64/obexd/client/transfer.c:442: deref_arg: Calling "g_obex_unref" dereferences freed pointer "transfer->obex".
#  440|   
#  441|   	if (transfer->obex)
#  442|-> 		g_obex_unref(transfer->obex);
#  443|   
#  444|   	g_free(transfer->callback);

Error: USE_AFTER_FREE (CWE-416):
bluez-5.64/obexd/client/transfer.c:411: freed_arg: "g_obex_cancel_req" frees "transfer->obex".
bluez-5.64/obexd/client/transfer.c:442: pass_freed_arg: Passing freed pointer "transfer->obex" as an argument to "g_obex_unref".
#  440|   
#  441|   	if (transfer->obex)
#  442|-> 		g_obex_unref(transfer->obex);
#  443|   
#  444|   	g_free(transfer->callback);

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/obexd/plugins/filesystem.c:411: alloc_arg: "g_file_get_contents" allocates memory that is stored into "buf".
bluez-5.64/obexd/plugins/filesystem.c:418: noescape: Resource "buf" is not freed or pointed-to in "g_string_new".
bluez-5.64/obexd/plugins/filesystem.c:440: leaked_storage: Variable "buf" going out of scope leaks the storage it points to.
#  438|   		*err = 0;
#  439|   
#  440|-> 	return object;
#  441|   
#  442|   fail:

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/obexd/plugins/messages-dummy.c:141: alloc_fn: Storage is returned from allocation function "get_next_subdir".
bluez-5.64/obexd/plugins/messages-dummy.c:141: var_assign: Assigning: "name" = storage returned from "get_next_subdir(dp, path)".
bluez-5.64/obexd/plugins/messages-dummy.c:141: overwrite_var: Overwriting "name" in "name = get_next_subdir(dp, path)" leaks the storage that "name" points to.
#  139|   	n = 0;
#  140|   
#  141|-> 	while ((name = get_next_subdir(dp, path)) != NULL) {
#  142|   		n++;
#  143|   		if (fld->max > 0)

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/plugins/sixaxis.c:425: alloc_arg: "get_pairing_type_for_device" allocates memory that is stored into "sysfs_path".
bluez-5.64/plugins/sixaxis.c:428: leaked_storage: Variable "sysfs_path" going out of scope leaks the storage it points to.
#  426|   	if (!cp || (cp->type != CABLE_PAIRING_SIXAXIS &&
#  427|   				cp->type != CABLE_PAIRING_DS4))
#  428|-> 		return;
#  429|   	if (bus != BUS_USB)
#  430|   		return;

Error: USE_AFTER_FREE (CWE-416):
bluez-5.64/plugins/sixaxis.c:442: closed_arg: "setup_device(int, char const *, struct cable_pairing const *, struct btd_adapter *)" closes "fd".
bluez-5.64/plugins/sixaxis.c:443: double_close: Calling "close(int)" closes handle "fd" which has already been closed.
#  441|   	/* Only close the fd if an authentication is not pending */
#  442|   	if (!setup_device(fd, sysfs_path, cp, adapter))
#  443|-> 		close(fd);
#  444|   
#  445|   	g_free(sysfs_path);

Error: USE_AFTER_FREE (CWE-416):
bluez-5.64/profiles/audio/avdtp.c:893: alias: Assigning: "req" = "l->data". Now both point to the same storage.
bluez-5.64/profiles/audio/avdtp.c:894: freed_arg: "pending_req_free" frees "req".
bluez-5.64/profiles/audio/avdtp.c:895: pass_freed_arg: Passing freed pointer "req" as an argument to "g_slist_remove".
#  893|   		req = l->data;
#  894|   		pending_req_free(req);
#  895|-> 		session->prio_queue = g_slist_remove(session->prio_queue, req);
#  896|   	}
#  897|   

Error: USE_AFTER_FREE (CWE-416):
bluez-5.64/profiles/audio/avdtp.c:900: alias: Assigning: "req" = "l->data". Now both point to the same storage.
bluez-5.64/profiles/audio/avdtp.c:901: freed_arg: "pending_req_free" frees "req".
bluez-5.64/profiles/audio/avdtp.c:902: pass_freed_arg: Passing freed pointer "req" as an argument to "g_slist_remove".
#  900|   		req = l->data;
#  901|   		pending_req_free(req);
#  902|-> 		session->req_queue = g_slist_remove(session->req_queue, req);
#  903|   	}
#  904|   }

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/profiles/audio/avrcp.c:3669: alloc_fn: Storage is returned from allocation function "g_slist_copy".
bluez-5.64/profiles/audio/avrcp.c:3669: var_assign: Assigning: "removed" = storage returned from "g_slist_copy(session->controller->players)".
bluez-5.64/profiles/audio/avrcp.c:3688: leaked_storage: Variable "removed" going out of scope leaks the storage it points to.
# 3686|   		if (i + len > operand_count) {
# 3687|   			error("Invalid player item length");
# 3688|-> 			return FALSE;
# 3689|   		}
# 3690|   

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/profiles/cups/sdp.c:41: alloc_fn: Storage is returned from allocation function "sdp_list_append".
bluez-5.64/profiles/cups/sdp.c:41: var_assign: Assigning: "attrs" = storage returned from "sdp_list_append(NULL, &attr1)".
bluez-5.64/profiles/cups/sdp.c:43: noescape: Resource "attrs" is not freed or pointed-to in "sdp_list_append".
bluez-5.64/profiles/cups/sdp.c:43: overwrite_var: Overwriting "attrs" in "attrs = sdp_list_append(attrs, &attr2)" leaks the storage that "attrs" points to.
#   41|   	attrs = sdp_list_append(NULL, &attr1);
#   42|   	attr2 = SDP_ATTR_ADD_PROTO_DESC_LIST;
#   43|-> 	attrs = sdp_list_append(attrs, &attr2);
#   44|   
#   45|   	err = sdp_service_search_attr_req(sdp, srch, SDP_ATTR_REQ_INDIVIDUAL, attrs, &rsp);

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/profiles/cups/sdp.c:43: alloc_fn: Storage is returned from allocation function "sdp_list_append".
bluez-5.64/profiles/cups/sdp.c:43: var_assign: Assigning: "attrs" = storage returned from "sdp_list_append(attrs, &attr2)".
bluez-5.64/profiles/cups/sdp.c:45: noescape: Resource "attrs" is not freed or pointed-to in "sdp_service_search_attr_req".
bluez-5.64/profiles/cups/sdp.c:47: leaked_storage: Variable "attrs" going out of scope leaks the storage it points to.
#   45|   	err = sdp_service_search_attr_req(sdp, srch, SDP_ATTR_REQ_INDIVIDUAL, attrs, &rsp);
#   46|   	if (err)
#   47|-> 		return -1;
#   48|   
#   49|   	for (; rsp; rsp = rsp->next) {

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/profiles/cups/sdp.c:38: alloc_fn: Storage is returned from allocation function "sdp_list_append".
bluez-5.64/profiles/cups/sdp.c:38: var_assign: Assigning: "srch" = storage returned from "sdp_list_append(NULL, &svclass)".
bluez-5.64/profiles/cups/sdp.c:45: noescape: Resource "srch" is not freed or pointed-to in "sdp_service_search_attr_req".
bluez-5.64/profiles/cups/sdp.c:47: leaked_storage: Variable "srch" going out of scope leaks the storage it points to.
#   45|   	err = sdp_service_search_attr_req(sdp, srch, SDP_ATTR_REQ_INDIVIDUAL, attrs, &rsp);
#   46|   	if (err)
#   47|-> 		return -1;
#   48|   
#   49|   	for (; rsp; rsp = rsp->next) {

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/profiles/cups/sdp.c:53: alloc_arg: "sdp_get_access_protos" allocates memory that is stored into "protos".
bluez-5.64/profiles/cups/sdp.c:54: noescape: Resource "protos" is not freed or pointed-to in "sdp_get_proto_port".
bluez-5.64/profiles/cups/sdp.c:61: noescape: Resource "protos" is not freed or pointed-to in "sdp_get_proto_port".
bluez-5.64/profiles/cups/sdp.c:64: leaked_storage: Variable "protos" going out of scope leaks the storage it points to.
#   62|   			if (psm > 0 && *ctrl_psm > 0) {
#   63|   				*data_psm = psm;
#   64|-> 				return 0;
#   65|   			}
#   66|   		}

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/profiles/cups/sdp.c:53: alloc_arg: "sdp_get_access_protos" allocates memory that is stored into "protos".
bluez-5.64/profiles/cups/sdp.c:54: noescape: Resource "protos" is not freed or pointed-to in "sdp_get_proto_port".
bluez-5.64/profiles/cups/sdp.c:61: noescape: Resource "protos" is not freed or pointed-to in "sdp_get_proto_port".
bluez-5.64/profiles/cups/sdp.c:67: leaked_storage: Variable "protos" going out of scope leaks the storage it points to.
#   65|   			}
#   66|   		}
#   67|-> 	}
#   68|   
#   69|   	return -1;

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/profiles/cups/sdp.c:86: alloc_fn: Storage is returned from allocation function "sdp_list_append".
bluez-5.64/profiles/cups/sdp.c:86: var_assign: Assigning: "attrs" = storage returned from "sdp_list_append(NULL, &attr)".
bluez-5.64/profiles/cups/sdp.c:88: noescape: Resource "attrs" is not freed or pointed-to in "sdp_service_search_attr_req".
bluez-5.64/profiles/cups/sdp.c:90: leaked_storage: Variable "attrs" going out of scope leaks the storage it points to.
#   88|   	err = sdp_service_search_attr_req(sdp, srch, SDP_ATTR_REQ_INDIVIDUAL, attrs, &rsp);
#   89|   	if (err)
#   90|-> 		return -1;
#   91|   
#   92|   	for (; rsp; rsp = rsp->next) {

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/profiles/cups/sdp.c:83: alloc_fn: Storage is returned from allocation function "sdp_list_append".
bluez-5.64/profiles/cups/sdp.c:83: var_assign: Assigning: "srch" = storage returned from "sdp_list_append(NULL, &svclass)".
bluez-5.64/profiles/cups/sdp.c:88: noescape: Resource "srch" is not freed or pointed-to in "sdp_service_search_attr_req".
bluez-5.64/profiles/cups/sdp.c:90: leaked_storage: Variable "srch" going out of scope leaks the storage it points to.
#   88|   	err = sdp_service_search_attr_req(sdp, srch, SDP_ATTR_REQ_INDIVIDUAL, attrs, &rsp);
#   89|   	if (err)
#   90|-> 		return -1;
#   91|   
#   92|   	for (; rsp; rsp = rsp->next) {

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/profiles/cups/sdp.c:96: alloc_arg: "sdp_get_access_protos" allocates memory that is stored into "protos".
bluez-5.64/profiles/cups/sdp.c:97: noescape: Resource "protos" is not freed or pointed-to in "sdp_get_proto_port".
bluez-5.64/profiles/cups/sdp.c:100: leaked_storage: Variable "protos" going out of scope leaks the storage it points to.
#   98|   			if (ch > 0) {
#   99|   				*channel = ch;
#  100|-> 				return 0;
#  101|   			}
#  102|   		}

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/profiles/cups/sdp.c:96: alloc_arg: "sdp_get_access_protos" allocates memory that is stored into "protos".
bluez-5.64/profiles/cups/sdp.c:97: noescape: Resource "protos" is not freed or pointed-to in "sdp_get_proto_port".
bluez-5.64/profiles/cups/sdp.c:103: leaked_storage: Variable "protos" going out of scope leaks the storage it points to.
#  101|   			}
#  102|   		}
#  103|-> 	}
#  104|   
#  105|   	return -1;

Error: BUFFER_SIZE (CWE-170):
bluez-5.64/profiles/input/device.c:938: buffer_size_warning: Calling "strncpy" with a maximum size argument of 128 bytes on destination array "ev.u.create.name" of size 128 bytes might leave the destination string unterminated.
#  936|   	memset(&ev, 0, sizeof(ev));
#  937|   	ev.type = UHID_CREATE;
#  938|-> 	strncpy((char *) ev.u.create.name, req->name, sizeof(ev.u.create.name));
#  939|   	ba2strlc(&idev->src, (char *) ev.u.create.phys);
#  940|   	ba2strlc(&idev->dst, (char *) ev.u.create.uniq);

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/src/advertising.c:839: alloc_fn: Storage is returned from allocation function "generate_adv_data".
bluez-5.64/src/advertising.c:839: var_assign: Assigning: "adv_data" = storage returned from "generate_adv_data(client, &flags, &adv_data_len)".
bluez-5.64/src/advertising.c:842: leaked_storage: Variable "adv_data" going out of scope leaks the storage it points to.
#  840|   	if (!adv_data || (adv_data_len > calc_max_adv_len(client, flags))) {
#  841|   		error("Advertising data too long or couldn't be generated.");
#  842|-> 		return -EINVAL;
#  843|   	}
#  844|   

Error: USE_AFTER_FREE (CWE-416):
bluez-5.64/src/device.c:3007: freed_arg: "device_connect_le" frees "device->bonding".
bluez-5.64/src/device.c:3018: double_free: Calling "bonding_request_free" frees pointer "device->bonding" which has already been freed.
# 3016|   
# 3017|   	if (err < 0) {
# 3018|-> 		bonding_request_free(device->bonding);
# 3019|   		return btd_error_failed(msg, strerror(-err));
# 3020|   	}

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/src/device.c:7089: alloc_fn: Storage is returned from allocation function "sdp_list_append".
bluez-5.64/src/device.c:7089: var_assign: Assigning: "recs" = storage returned from "sdp_list_append(recs, rec)".
bluez-5.64/src/device.c:7089: noescape: Resource "recs" is not freed or pointed-to in "sdp_list_append".
bluez-5.64/src/device.c:7089: overwrite_var: Overwriting "recs" in "recs = sdp_list_append(recs, rec)" leaks the storage that "recs" points to.
# 7087|   
# 7088|   		rec = record_from_string(str);
# 7089|-> 		recs = sdp_list_append(recs, rec);
# 7090|   		g_free(str);
# 7091|   	}

Error: USE_AFTER_FREE (CWE-416):
bluez-5.64/src/gatt-database.c:3878: freed_arg: "send_notification_to_device" frees "state".
bluez-5.64/src/gatt-database.c:3880: deref_after_free: Dereferencing freed pointer "state".
# 3878|   	send_notification_to_device(state, state->pending);
# 3879|   
# 3880|-> 	free(state->pending->value);
# 3881|   	free(state->pending);
# 3882|   	state->pending = NULL;

Error: USE_AFTER_FREE (CWE-416):
bluez-5.64/src/gatt-database.c:3878: freed_arg: "send_notification_to_device" frees "state->pending".
bluez-5.64/src/gatt-database.c:3880: deref_after_free: Dereferencing freed pointer "state->pending".
# 3878|   	send_notification_to_device(state, state->pending);
# 3879|   
# 3880|-> 	free(state->pending->value);
# 3881|   	free(state->pending);
# 3882|   	state->pending = NULL;

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/src/main.c:359: alloc_fn: Storage is returned from allocation function "g_key_file_get_string".
bluez-5.64/src/main.c:359: var_assign: Assigning: "str" = storage returned from "g_key_file_get_string(config, group, params[i].val_name, &err)".
bluez-5.64/src/main.c:368: identity_transfer: Passing "str" as argument 1 to function "strtol", which sets "endptr" to that argument.
bluez-5.64/src/main.c:370: leaked_storage: Variable "endptr" going out of scope leaks the storage it points to.
bluez-5.64/src/main.c:370: leaked_storage: Variable "str" going out of scope leaks the storage it points to.
#  368|   			val = strtol(str, &endptr, 0);
#  369|   			if (!endptr || *endptr != '\0')
#  370|-> 				continue;
#  371|   
#  372|   			info("%s=%s(%d)", params[i].val_name, str, val);

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/src/main.c:359: alloc_fn: Storage is returned from allocation function "g_key_file_get_string".
bluez-5.64/src/main.c:359: var_assign: Assigning: "str" = storage returned from "g_key_file_get_string(config, group, params[i].val_name, &err)".
bluez-5.64/src/main.c:368: identity_transfer: Passing "str" as argument 1 to function "strtol", which sets "endptr" to that argument.
bluez-5.64/src/main.c:372: noescape: Assuming resource "str" is not freed or pointed-to as ellipsis argument to "info".
bluez-5.64/src/main.c:380: leaked_storage: Variable "endptr" going out of scope leaks the storage it points to.
bluez-5.64/src/main.c:381: leaked_storage: Variable "str" going out of scope leaks the storage it points to.
#  379|   			++btd_opts.defaults.num_entries;
#  380|   		}
#  381|-> 	}
#  382|   }
#  383|   

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/src/main.c:673: alloc_fn: Storage is returned from allocation function "g_key_file_get_string".
bluez-5.64/src/main.c:673: var_assign: Assigning: "str" = storage returned from "g_key_file_get_string(config, "General", "Privacy", &err)".
bluez-5.64/src/main.c:709: overwrite_var: Overwriting "str" in "str = g_key_file_get_string(config, "General", "JustWorksRepairing", &err)" leaks the storage that "str" points to.
#  707|   	}
#  708|   
#  709|-> 	str = g_key_file_get_string(config, "General",
#  710|   						"JustWorksRepairing", &err);
#  711|   	if (err) {

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/src/main.c:709: alloc_fn: Storage is returned from allocation function "g_key_file_get_string".
bluez-5.64/src/main.c:709: var_assign: Assigning: "str" = storage returned from "g_key_file_get_string(config, "General", "JustWorksRepairing", &err)".
bluez-5.64/src/main.c:731: overwrite_var: Overwriting "str" in "str = g_key_file_get_string(config, "General", "Name", &err)" leaks the storage that "str" points to.
#  729|   	}
#  730|   
#  731|-> 	str = g_key_file_get_string(config, "General", "Name", &err);
#  732|   	if (err) {
#  733|   		DBG("%s", err->message);

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/src/main.c:731: alloc_fn: Storage is returned from allocation function "g_key_file_get_string".
bluez-5.64/src/main.c:731: var_assign: Assigning: "str" = storage returned from "g_key_file_get_string(config, "General", "Name", &err)".
bluez-5.64/src/main.c:741: overwrite_var: Overwriting "str" in "str = g_key_file_get_string(config, "General", "Class", &err)" leaks the storage that "str" points to.
#  739|   	}
#  740|   
#  741|-> 	str = g_key_file_get_string(config, "General", "Class", &err);
#  742|   	if (err) {
#  743|   		DBG("%s", err->message);

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/src/main.c:741: alloc_fn: Storage is returned from allocation function "g_key_file_get_string".
bluez-5.64/src/main.c:741: var_assign: Assigning: "str" = storage returned from "g_key_file_get_string(config, "General", "Class", &err)".
bluez-5.64/src/main.c:751: overwrite_var: Overwriting "str" in "str = g_key_file_get_string(config, "General", "DeviceID", &err)" leaks the storage that "str" points to.
#  749|   	}
#  750|   
#  751|-> 	str = g_key_file_get_string(config, "General", "DeviceID", &err);
#  752|   	if (err) {
#  753|   		DBG("%s", err->message);

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/src/main.c:751: alloc_fn: Storage is returned from allocation function "g_key_file_get_string".
bluez-5.64/src/main.c:751: var_assign: Assigning: "str" = storage returned from "g_key_file_get_string(config, "General", "DeviceID", &err)".
bluez-5.64/src/main.c:783: overwrite_var: Overwriting "str" in "str = g_key_file_get_string(config, "General", "ControllerMode", &err)" leaks the storage that "str" points to.
#  781|   		btd_opts.debug_keys = boolean;
#  782|   
#  783|-> 	str = g_key_file_get_string(config, "General", "ControllerMode", &err);
#  784|   	if (err) {
#  785|   		g_clear_error(&err);

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/src/main.c:783: alloc_fn: Storage is returned from allocation function "g_key_file_get_string".
bluez-5.64/src/main.c:783: var_assign: Assigning: "str" = storage returned from "g_key_file_get_string(config, "General", "ControllerMode", &err)".
bluez-5.64/src/main.c:800: overwrite_var: Overwriting "str" in "str = g_key_file_get_string(config, "General", "MultiProfile", &err)" leaks the storage that "str" points to.
#  798|   	}
#  799|   
#  800|-> 	str = g_key_file_get_string(config, "General", "MultiProfile", &err);
#  801|   	if (err) {
#  802|   		g_clear_error(&err);

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/src/main.c:800: alloc_fn: Storage is returned from allocation function "g_key_file_get_string".
bluez-5.64/src/main.c:800: var_assign: Assigning: "str" = storage returned from "g_key_file_get_string(config, "General", "MultiProfile", &err)".
bluez-5.64/src/main.c:849: overwrite_var: Overwriting "str" in "str = g_key_file_get_string(config, "GATT", "Cache", &err)" leaks the storage that "str" points to.
#  847|   	}
#  848|   
#  849|-> 	str = g_key_file_get_string(config, "GATT", "Cache", &err);
#  850|   	if (err) {
#  851|   		DBG("%s", err->message);

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/src/main.c:849: alloc_fn: Storage is returned from allocation function "g_key_file_get_string".
bluez-5.64/src/main.c:849: var_assign: Assigning: "str" = storage returned from "g_key_file_get_string(config, "GATT", "Cache", &err)".
bluez-5.64/src/main.c:893: overwrite_var: Overwriting "str" in "str = g_key_file_get_string(config, "AVDTP", "SessionMode", &err)" leaks the storage that "str" points to.
#  891|   	}
#  892|   
#  893|-> 	str = g_key_file_get_string(config, "AVDTP", "SessionMode", &err);
#  894|   	if (err) {
#  895|   		DBG("%s", err->message);

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/src/main.c:893: alloc_fn: Storage is returned from allocation function "g_key_file_get_string".
bluez-5.64/src/main.c:893: var_assign: Assigning: "str" = storage returned from "g_key_file_get_string(config, "AVDTP", "SessionMode", &err)".
bluez-5.64/src/main.c:911: overwrite_var: Overwriting "str" in "str = g_key_file_get_string(config, "AVDTP", "StreamMode", &err)" leaks the storage that "str" points to.
#  909|   	}
#  910|   
#  911|-> 	str = g_key_file_get_string(config, "AVDTP", "StreamMode", &err);
#  912|   	if (err) {
#  913|   		DBG("%s", err->message);

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/src/main.c:911: alloc_fn: Storage is returned from allocation function "g_key_file_get_string".
bluez-5.64/src/main.c:911: var_assign: Assigning: "str" = storage returned from "g_key_file_get_string(config, "AVDTP", "StreamMode", &err)".
bluez-5.64/src/main.c:943: leaked_storage: Variable "str" going out of scope leaks the storage it points to.
#  941|   	parse_br_config(config);
#  942|   	parse_le_config(config);
#  943|-> }
#  944|   
#  945|   static void init_defaults(void)

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/src/main.c:830: alloc_fn: Storage is returned from allocation function "g_key_file_get_string_list".
bluez-5.64/src/main.c:830: var_assign: Assigning: "strlist" = storage returned from "g_key_file_get_string_list(config, "General", "Experimental", NULL, &err)".
bluez-5.64/src/main.c:943: leaked_storage: Variable "strlist" going out of scope leaks the storage it points to.
#  941|   	parse_br_config(config);
#  942|   	parse_le_config(config);
#  943|-> }
#  944|   
#  945|   static void init_defaults(void)

Error: BUFFER_SIZE (CWE-170):
bluez-5.64/src/profile.c:1997: buffer_size_warning: Calling "strncpy" with a maximum size argument of 37 bytes on destination array "svc_str" of size 37 bytes might leave the destination string unterminated.
# 1995|   		sdp_uuid2strn(&uuid, svc_str, sizeof(svc_str));
# 1996|   	} else {
# 1997|-> 		strncpy(svc_str, uuid_str, sizeof(svc_str));
# 1998|   	}
# 1999|   

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/src/sdpd-request.c:265: alloc_fn: Storage is returned from allocation function "sdp_list_append".
bluez-5.64/src/sdpd-request.c:265: var_assign: Assigning: "pSeq" = storage returned from "sdp_list_append(pSeq, pElem)".
bluez-5.64/src/sdpd-request.c:262: leaked_storage: Variable "pSeq" going out of scope leaks the storage it points to.
#  260|   			break;
#  261|   		default:
#  262|-> 			return -1;
#  263|   		}
#  264|   		if (status == 0) {

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/src/sdpd-request.c:265: alloc_fn: Storage is returned from allocation function "sdp_list_append".
bluez-5.64/src/sdpd-request.c:265: var_assign: Assigning: "pSeq" = storage returned from "sdp_list_append(pSeq, pElem)".
bluez-5.64/src/sdpd-request.c:265: identity_transfer: Passing "pSeq" as argument 1 to function "sdp_list_append", which returns that argument.
bluez-5.64/src/sdpd-request.c:265: noescape: Resource "pSeq" is not freed or pointed-to in "sdp_list_append".
bluez-5.64/src/sdpd-request.c:265: var_assign: Assigning: "pSeq" = storage returned from "sdp_list_append(pSeq, pElem)".
bluez-5.64/src/sdpd-request.c:265: identity_transfer: Passing "pSeq" as argument 1 to function "sdp_list_append", which returns that argument.
bluez-5.64/src/sdpd-request.c:265: noescape: Resource "pSeq" is not freed or pointed-to in "sdp_list_append".
bluez-5.64/src/sdpd-request.c:265: var_assign: Assigning: "pSeq" = storage returned from "sdp_list_append(pSeq, pElem)".
bluez-5.64/src/sdpd-request.c:265: identity_transfer: Passing "pSeq" as argument 1 to function "sdp_list_append", which returns that argument.
bluez-5.64/src/sdpd-request.c:265: noescape: Resource "pSeq" is not freed or pointed-to in "sdp_list_append".
bluez-5.64/src/sdpd-request.c:265: var_assign: Assigning: "pSeq" = storage returned from "sdp_list_append(pSeq, pElem)".
bluez-5.64/src/sdpd-request.c:265: noescape: Resource "pSeq" is not freed or pointed-to in "sdp_list_append".
bluez-5.64/src/sdpd-request.c:265: overwrite_var: Overwriting "pSeq" in "pSeq = sdp_list_append(pSeq, pElem)" leaks the storage that "pSeq" points to.
#  263|   		}
#  264|   		if (status == 0) {
#  265|-> 			pSeq = sdp_list_append(pSeq, pElem);
#  266|   			numberOfElements++;
#  267|   			SDPDBG("No of elements : %d", numberOfElements);

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/tools/avtest.c:327: open_fn: Returning handle opened by "accept".
bluez-5.64/tools/avtest.c:327: var_assign: Assigning: "media_sock" = handle returned from "accept(srv_sk, (struct sockaddr *)&addr, &optlen)".
bluez-5.64/tools/avtest.c:327: overwrite_var: Overwriting handle "media_sock" in "media_sock = accept(srv_sk, (struct sockaddr *)&addr, &optlen)" leaks the handle.
#  325|   				optlen = sizeof(addr);
#  326|   
#  327|-> 				media_sock = accept(srv_sk,
#  328|   						(struct sockaddr *) &addr,
#  329|   								&optlen);

Error: BUFFER_SIZE (CWE-170):
bluez-5.64/tools/bneptest.c:80: buffer_size_warning: Calling "strncpy" with a maximum size argument of 16 bytes on destination array "ifr.ifr_ifrn.ifrn_name" of size 16 bytes might leave the destination string unterminated.
#   78|   
#   79|   	memset(&ifr, 0, sizeof(ifr));
#   80|-> 	strncpy(ifr.ifr_name, bridge, IFNAMSIZ);
#   81|   	ifr.ifr_data = (char *) args;
#   82|   

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/tools/btproxy.c:513: alloc_fn: Storage is returned from allocation function "util_malloc".
bluez-5.64/tools/btproxy.c:513: var_assign: Assigning: "__p" = storage returned from "util_malloc(__n * __s)".
bluez-5.64/tools/btproxy.c:513: noescape: Resource "__p" is not freed or pointed-to in "memset". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.64/tools/btproxy.c:513: leaked_storage: Variable "__p" going out of scope leaks the storage it points to.
bluez-5.64/tools/btproxy.c:513: var_assign: Assigning: "proxy" = "({...; __p;})".
bluez-5.64/tools/btproxy.c:527: noescape: Resource "proxy" is not freed or pointed-to in "mainloop_add_fd".
bluez-5.64/tools/btproxy.c:530: noescape: Resource "proxy" is not freed or pointed-to in "mainloop_add_fd".
bluez-5.64/tools/btproxy.c:533: leaked_storage: Variable "proxy" going out of scope leaks the storage it points to.
#  531|   				dev_read_callback, proxy, dev_read_destroy);
#  532|   
#  533|-> 	return true;
#  534|   }
#  535|   

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/tools/cltest.c:41: open_fn: Returning handle opened by "socket".
bluez-5.64/tools/cltest.c:41: var_assign: Assigning: "fd" = handle returned from "socket(31, 524290, 0)".
bluez-5.64/tools/cltest.c:51: noescape: Resource "fd" is not freed or pointed-to in "bind".
bluez-5.64/tools/cltest.c:62: noescape: Resource "fd" is not freed or pointed-to in "connect".
bluez-5.64/tools/cltest.c:68: noescape: Resource "fd" is not freed or pointed-to in "send".
bluez-5.64/tools/cltest.c:75: leaked_handle: Handle variable "fd" going out of scope leaks the handle.
#   73|   	}
#   74|   
#   75|-> 	return true;
#   76|   }
#   77|   

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/tools/cltest.c:116: open_fn: Returning handle opened by "socket".
bluez-5.64/tools/cltest.c:116: var_assign: Assigning: "fd" = handle returned from "socket(31, 524290, 0)".
bluez-5.64/tools/cltest.c:127: noescape: Resource "fd" is not freed or pointed-to in "bind".
bluez-5.64/tools/cltest.c:133: noescape: Resource "fd" is not freed or pointed-to in "mainloop_add_fd".
bluez-5.64/tools/cltest.c:135: leaked_handle: Handle variable "fd" going out of scope leaks the handle.
#  133|   	mainloop_add_fd(fd, EPOLLIN, receiver_callback, NULL, NULL);
#  134|   
#  135|-> 	return true;
#  136|   }
#  137|   

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/tools/create-image.c:82: open_fn: Returning handle opened by "open". [Note: The source code implementation of the function has been overridden by a user model.]
bluez-5.64/tools/create-image.c:82: var_assign: Assigning: "fd" = handle returned from "open(pathname, 524288)".
bluez-5.64/tools/create-image.c:90: noescape: Resource "fd" is not freed or pointed-to in "fstat".
bluez-5.64/tools/create-image.c:98: noescape: Resource "fd" is not freed or pointed-to in "mmap".
bluez-5.64/tools/create-image.c:124: leaked_handle: Handle variable "fd" going out of scope leaks the handle.
#  122|   		close(fd);
#  123|   	}
#  124|-> }
#  125|   
#  126|   static void usage(void)

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/tools/create-image.c:98: alloc_fn: Storage is returned from allocation function "mmap".
bluez-5.64/tools/create-image.c:98: var_assign: Assigning: "map" = storage returned from "mmap(NULL, st.st_size, 1, 1, fd, 0L)".
bluez-5.64/tools/create-image.c:124: leaked_storage: Variable "map" going out of scope leaks the storage it points to.
#  122|   		close(fd);
#  123|   	}
#  124|-> }
#  125|   
#  126|   static void usage(void)

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/tools/l2cap-tester.c:1703: open_fn: Returning handle opened by "accept".
bluez-5.64/tools/l2cap-tester.c:1703: var_assign: Assigning: "new_sk" = handle returned from "accept(sk, NULL, NULL)".
bluez-5.64/tools/l2cap-tester.c:1710: noescape: Resource "new_sk" is not freed or pointed-to in "check_mtu".
bluez-5.64/tools/l2cap-tester.c:1712: leaked_handle: Handle variable "new_sk" going out of scope leaks the handle.
# 1710|   	if (!check_mtu(data, new_sk)) {
# 1711|   		tester_test_failed();
# 1712|-> 		return FALSE;
# 1713|   	}
# 1714|   

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/tools/mesh-cfgclient.c:1515: alloc_fn: Storage is returned from allocation function "l_util_from_hexstring".
bluez-5.64/tools/mesh-cfgclient.c:1515: var_assign: Assigning: "uuid" = storage returned from "l_util_from_hexstring(str, &sz)".
bluez-5.64/tools/mesh-cfgclient.c:1518: leaked_storage: Variable "uuid" going out of scope leaks the storage it points to.
# 1516|   	if (!uuid || sz != 16 || !l_uuid_is_valid(uuid)) {
# 1517|   		l_error("Failed to generate UUID array from %s", str);
# 1518|-> 		return;
# 1519|   	}
# 1520|   

Error: USE_AFTER_FREE (CWE-416):
bluez-5.64/tools/mesh-gatt/prov-db.c:847: freed_arg: "g_free" frees "in_str".
bluez-5.64/tools/mesh-gatt/prov-db.c:867: double_free: Calling "g_free" frees pointer "in_str" which has already been freed.
#  865|   done:
#  866|   
#  867|-> 	g_free(in_str);
#  868|   
#  869|   	if(jmain)

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/tools/mesh/mesh-db.c:2370: open_fn: Returning handle opened by "open". [Note: The source code implementation of the function has been overridden by a user model.]
bluez-5.64/tools/mesh/mesh-db.c:2370: var_assign: Assigning: "fd" = handle returned from "open(fname, 0)".
bluez-5.64/tools/mesh/mesh-db.c:2374: noescape: Resource "fd" is not freed or pointed-to in "fstat".
bluez-5.64/tools/mesh/mesh-db.c:2385: noescape: Resource "fd" is not freed or pointed-to in "read". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.64/tools/mesh/mesh-db.c:2388: leaked_handle: Handle variable "fd" going out of scope leaks the handle.
# 2386|   	if (sz != st.st_size) {
# 2387|   		l_error("Failed to read configuration file %s", fname);
# 2388|-> 		return false;
# 2389|   	}
# 2390|   

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/tools/mesh/mesh-db.c:2379: alloc_fn: Storage is returned from allocation function "l_malloc".
bluez-5.64/tools/mesh/mesh-db.c:2379: var_assign: Assigning: "__p" = storage returned from "l_malloc(__n * __s)".
bluez-5.64/tools/mesh/mesh-db.c:2379: noescape: Resource "__p" is not freed or pointed-to in "memset". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.64/tools/mesh/mesh-db.c:2379: leaked_storage: Variable "__p" going out of scope leaks the storage it points to.
bluez-5.64/tools/mesh/mesh-db.c:2379: var_assign: Assigning: "str" = "({...; __p;})".
bluez-5.64/tools/mesh/mesh-db.c:2385: noescape: Resource "str" is not freed or pointed-to in "read". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.64/tools/mesh/mesh-db.c:2388: leaked_storage: Variable "str" going out of scope leaks the storage it points to.
# 2386|   	if (sz != st.st_size) {
# 2387|   		l_error("Failed to read configuration file %s", fname);
# 2388|-> 		return false;
# 2389|   	}
# 2390|   

Error: USE_AFTER_FREE (CWE-416):
bluez-5.64/tools/meshctl.c:1968: freed_arg: "g_free" frees "mesh_dir".
bluez-5.64/tools/meshctl.c:2018: double_free: Calling "g_free" frees pointer "mesh_dir" which has already been freed.
# 2016|   fail:
# 2017|   	bt_shell_cleanup();
# 2018|-> 	g_free(mesh_dir);
# 2019|   
# 2020|   	return EXIT_FAILURE;

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/tools/obex-client-tool.c:304: open_fn: Returning handle opened by "socket".
bluez-5.64/tools/obex-client-tool.c:304: var_assign: Assigning: "sk" = handle returned from "socket(1, sock_type, 0)".
bluez-5.64/tools/obex-client-tool.c:312: noescape: Resource "sk" is not freed or pointed-to in "connect".
bluez-5.64/tools/obex-client-tool.c:315: leaked_handle: Handle variable "sk" going out of scope leaks the handle.
#  313|   		err = errno;
#  314|   		g_printerr("connect: %s (%d)\n", strerror(err), err);
#  315|-> 		return NULL;
#  316|   	}
#  317|   

Error: USE_AFTER_FREE (CWE-672):
bluez-5.64/tools/rctest.c:358: closed_arg: "close(int)" closes "sk".
bluez-5.64/tools/rctest.c:371: pass_closed_arg: Passing closed handle "sk" as an argument to "setsockopt".
#  369|   		}
#  370|   
#  371|-> 		if (priority > 0 && setsockopt(sk, SOL_SOCKET, SO_PRIORITY,
#  372|   					&priority, sizeof(priority)) < 0) {
#  373|   			syslog(LOG_ERR, "Can't set socket priority: %s (%d)",

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/tools/sco-tester.c:534: open_fn: Returning handle opened by "socket".
bluez-5.64/tools/sco-tester.c:534: var_assign: Assigning: "sk" = handle returned from "socket(31, 2053, 2)".
bluez-5.64/tools/sco-tester.c:546: leaked_handle: Handle variable "sk" going out of scope leaks the handle.
#  544|   	if (!central_bdaddr) {
#  545|   		tester_warn("No central bdaddr");
#  546|-> 		return -ENODEV;
#  547|   	}
#  548|   

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/tools/test-runner.c:678: open_fn: Returning handle opened by "attach_proto".
bluez-5.64/tools/test-runner.c:678: var_assign: Assigning: "serial_fd" = handle returned from "attach_proto(node, 0U, basic_flags, extra_flags)".
bluez-5.64/tools/test-runner.c:706: leaked_handle: Handle variable "serial_fd" going out of scope leaks the handle.
#  704|   		if (chdir(home + 5) < 0) {
#  705|   			perror("Failed to change home test directory");
#  706|-> 			return;
#  707|   		}
#  708|   

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/tools/test-runner.c:678: open_fn: Returning handle opened by "attach_proto".
bluez-5.64/tools/test-runner.c:678: var_assign: Assigning: "serial_fd" = handle returned from "attach_proto(node, 0U, basic_flags, extra_flags)".
bluez-5.64/tools/test-runner.c:713: leaked_handle: Handle variable "serial_fd" going out of scope leaks the handle.
#  711|   
#  712|   			if (!test_table[idx])
#  713|-> 				return;
#  714|   
#  715|   			if (!stat(test_table[idx], &st))

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/tools/test-runner.c:678: open_fn: Returning handle opened by "attach_proto".
bluez-5.64/tools/test-runner.c:678: var_assign: Assigning: "serial_fd" = handle returned from "attach_proto(node, 0U, basic_flags, extra_flags)".
bluez-5.64/tools/test-runner.c:738: leaked_handle: Handle variable "serial_fd" going out of scope leaks the handle.
#  736|   	if (pid < 0) {
#  737|   		perror("Failed to fork new process");
#  738|-> 		return;
#  739|   	}
#  740|   

