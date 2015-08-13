Return-Path: <cyrus@holtmann.org>
From: Atul Rai <a.rai@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com
Subject: Re: [PATCH BlueZ] tools/hcitool: Fix memory leak before exit
Date: Thu, 13 Aug 2015 10:58:01 +0530
Message-id: <1439443681-30282-1-git-send-email-a.rai@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping
> ------- Original Message -------
> Sender : Atul Kumar Rai<a.rai@samsung.com> Lead Engineer (1)/SRI-Delhi-SWC Group/Samsung Electronics
> Date : Aug 04, 2015 11:29 (GMT+05:30)
> Title : [PATCH BlueZ] tools/hcitool: Fix memory leak before exit

> In case of failure, before exiting, free dynamically allocated
> memory as well as remove reference to opened device.
> ---
>  tools/hcitool.c | 226 +++++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 174 insertions(+), 52 deletions(-)
> 
> diff --git a/tools/hcitool.c b/tools/hcitool.c
> index 02c4ebe..a420e4d 100644
> --- a/tools/hcitool.c
> +++ b/tools/hcitool.c
> @@ -166,7 +166,7 @@ static int conn_list(int s, int dev_id, long arg)
>  
>  	if (ioctl(s, HCIGETCONNLIST, (void *) cl)) {
>  		perror("Can't get connection list");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	for (i = 0; i < cl->conn_num; i++, ci++) {
> @@ -182,6 +182,10 @@ static int conn_list(int s, int dev_id, long arg)
>  
>  	free(cl);
>  	return 0;
> +
> +failure:
> +	free(cl);
> +	exit(EXIT_FAILURE);
>  }
>  
>  static int find_conn(int s, int dev_id, long arg)
> @@ -200,7 +204,7 @@ static int find_conn(int s, int dev_id, long arg)
>  
>  	if (ioctl(s, HCIGETCONNLIST, (void *) cl)) {
>  		perror("Can't get connection list");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	for (i = 0; i < cl->conn_num; i++, ci++)
> @@ -211,6 +215,10 @@ static int find_conn(int s, int dev_id, long arg)
>  
>  	free(cl);
>  	return 0;
> +
> +failure:
> +	free(cl);
> +	exit(EXIT_FAILURE);
>  }
>  
>  static void hex_dump(char *pref, int width, unsigned char *buf, int len)
> @@ -1325,14 +1333,14 @@ static void cmd_dc(int dev_id, int argc, char **argv)
>  	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
>  	if (!cr) {
>  		perror("Can't allocate memory");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	bacpy(&cr->bdaddr, &bdaddr);
>  	cr->type = ACL_LINK;
>  	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
>  		perror("Get connection info failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	if (hci_disconnect(dd, htobs(cr->conn_info->handle),
> @@ -1342,6 +1350,13 @@ static void cmd_dc(int dev_id, int argc, char **argv)
>  	free(cr);
>  
>  	hci_close_dev(dd);
> +
> +	return;
> +
> +failure:
> +	free(cr);
> +	hci_close_dev(dd);
> +	exit(EXIT_FAILURE);
>  }
>  
>  /* Role switch */
> @@ -1399,10 +1414,15 @@ static void cmd_sr(int dev_id, int argc, char **argv)
>  
>  	if (hci_switch_role(dd, &bdaddr, role, 10000) < 0) {
>  		perror("Switch role request failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	hci_close_dev(dd);
> +	return;
> +
> +failure:
> +	hci_close_dev(dd);
> +	exit(EXIT_FAILURE);
>  }
>  
>  /* Read RSSI */
> @@ -1451,19 +1471,19 @@ static void cmd_rssi(int dev_id, int argc, char **argv)
>  	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
>  	if (!cr) {
>  		perror("Can't allocate memory");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	bacpy(&cr->bdaddr, &bdaddr);
>  	cr->type = ACL_LINK;
>  	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
>  		perror("Get connection info failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	if (hci_read_rssi(dd, htobs(cr->conn_info->handle), &rssi, 1000) < 0) {
>  		perror("Read RSSI failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	printf("RSSI return value: %d\n", rssi);
> @@ -1471,6 +1491,13 @@ static void cmd_rssi(int dev_id, int argc, char **argv)
>  	free(cr);
>  
>  	hci_close_dev(dd);
> +
> +	return;
> +
> +failure:
> +	free(cr);
> +	hci_close_dev(dd);
> +	exit(EXIT_FAILURE);
>  }
>  
>  /* Get link quality */
> @@ -1519,19 +1546,19 @@ static void cmd_lq(int dev_id, int argc, char **argv)
>  	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
>  	if (!cr) {
>  		perror("Can't allocate memory");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	bacpy(&cr->bdaddr, &bdaddr);
>  	cr->type = ACL_LINK;
>  	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
>  		perror("Get connection info failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	if (hci_read_link_quality(dd, htobs(cr->conn_info->handle), &lq, 1000) < 0) {
>  		perror("HCI read_link_quality request failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	printf("Link quality: %d\n", lq);
> @@ -1539,6 +1566,13 @@ static void cmd_lq(int dev_id, int argc, char **argv)
>  	free(cr);
>  
>  	hci_close_dev(dd);
> +
> +	return;
> +
> +failure:
> +	free(cr);
> +	hci_close_dev(dd);
> +	exit(EXIT_FAILURE);
>  }
>  
>  /* Get transmit power level */
> @@ -1589,19 +1623,19 @@ static void cmd_tpl(int dev_id, int argc, char **argv)
>  	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
>  	if (!cr) {
>  		perror("Can't allocate memory");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	bacpy(&cr->bdaddr, &bdaddr);
>  	cr->type = ACL_LINK;
>  	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
>  		perror("Get connection info failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	if (hci_read_transmit_power_level(dd, htobs(cr->conn_info->handle), type, &level, 1000) < 0) {
>  		perror("HCI read transmit power level request failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	printf("%s transmit power level: %d\n",
> @@ -1610,6 +1644,13 @@ static void cmd_tpl(int dev_id, int argc, char **argv)
>  	free(cr);
>  
>  	hci_close_dev(dd);
> +
> +	return;
> +
> +failure:
> +	free(cr);
> +	hci_close_dev(dd);
> +	exit(EXIT_FAILURE);
>  }
>  
>  /* Get AFH channel map */
> @@ -1659,21 +1700,21 @@ static void cmd_afh(int dev_id, int argc, char **argv)
>  	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
>  	if (!cr) {
>  		perror("Can't allocate memory");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	bacpy(&cr->bdaddr, &bdaddr);
>  	cr->type = ACL_LINK;
>  	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
>  		perror("Get connection info failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	handle = htobs(cr->conn_info->handle);
>  
>  	if (hci_read_afh_map(dd, handle, &mode, map, 1000) < 0) {
>  		perror("HCI read AFH map request failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	if (mode == 0x01) {
> @@ -1688,6 +1729,13 @@ static void cmd_afh(int dev_id, int argc, char **argv)
>  	free(cr);
>  
>  	hci_close_dev(dd);
> +
> +	return;
> +
> +failure:
> +	free(cr);
> +	hci_close_dev(dd);
> +	exit(EXIT_FAILURE);
>  }
>  
>  /* Set connection packet type */
> @@ -1740,14 +1788,14 @@ static void cmd_cpt(int dev_id, int argc, char **argv)
>  	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
>  	if (!cr) {
>  		perror("Can't allocate memory");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	bacpy(&cr->bdaddr, &bdaddr);
>  	cr->type = ACL_LINK;
>  	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
>  		perror("Get connection info failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	cp.handle   = htobs(cr->conn_info->handle);
> @@ -1764,12 +1812,19 @@ static void cmd_cpt(int dev_id, int argc, char **argv)
>  
>  	if (hci_send_req(dd, &rq, 100) < 0) {
>  		perror("Packet type change failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	free(cr);
>  
>  	hci_close_dev(dd);
> +
> +	return;
> +
> +failure:
> +	free(cr);
> +	hci_close_dev(dd);
> +	exit(EXIT_FAILURE);
>  }
>  
>  /* Get/Set link policy settings */
> @@ -1818,14 +1873,14 @@ static void cmd_lp(int dev_id, int argc, char **argv)
>  	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
>  	if (!cr) {
>  		perror("Can't allocate memory");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	bacpy(&cr->bdaddr, &bdaddr);
>  	cr->type = ACL_LINK;
>  	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
>  		perror("Get connection info failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	if (argc == 1) {
> @@ -1833,7 +1888,7 @@ static void cmd_lp(int dev_id, int argc, char **argv)
>  		if (hci_read_link_policy(dd, htobs(cr->conn_info->handle),
>  							&policy, 1000) < 0) {
>  			perror("HCI read_link_policy_settings request failed");
> -			exit(1);
> +			goto failure;
>  		}
>  
>  		policy = btohs(policy);
> @@ -1843,26 +1898,33 @@ static void cmd_lp(int dev_id, int argc, char **argv)
>  			bt_free(str);
>  		} else {
>  			fprintf(stderr, "Invalig settings\n");
> -			exit(1);
> +			goto failure;
>  		}
>  	} else {
>  		unsigned int val;
>  		if (hci_strtolp(argv[1], &val) < 0) {
>  			fprintf(stderr, "Invalig arguments\n");
> -			exit(1);
> +			goto failure;
>  		}
>  		policy = val;
>  
>  		if (hci_write_link_policy(dd, htobs(cr->conn_info->handle),
>  						htobs(policy), 1000) < 0) {
>  			perror("HCI write_link_policy_settings request failed");
> -			exit(1);
> +			goto failure;
>  		}
>  	}
>  
>  	free(cr);
>  
>  	hci_close_dev(dd);
> +
> +	return;
> +
> +failure:
> +	free(cr);
> +	hci_close_dev(dd);
> +	exit(EXIT_FAILURE);
>  }
>  
>  /* Get/Set link supervision timeout */
> @@ -1911,21 +1973,21 @@ static void cmd_lst(int dev_id, int argc, char **argv)
>  	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
>  	if (!cr) {
>  		perror("Can't allocate memory");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	bacpy(&cr->bdaddr, &bdaddr);
>  	cr->type = ACL_LINK;
>  	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
>  		perror("Get connection info failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	if (argc == 1) {
>  		if (hci_read_link_supervision_timeout(dd, htobs(cr->conn_info->handle),
>  							&timeout, 1000) < 0) {
>  			perror("HCI read_link_supervision_timeout request failed");
> -			exit(1);
> +			goto failure;
>  		}
>  
>  		timeout = btohs(timeout);
> @@ -1941,13 +2003,20 @@ static void cmd_lst(int dev_id, int argc, char **argv)
>  		if (hci_write_link_supervision_timeout(dd, htobs(cr->conn_info->handle),
>  							htobs(timeout), 1000) < 0) {
>  			perror("HCI write_link_supervision_timeout request failed");
> -			exit(1);
> +			goto failure;
>  		}
>  	}
>  
>  	free(cr);
>  
>  	hci_close_dev(dd);
> +
> +	return;
> +
> +failure:
> +	free(cr);
> +	hci_close_dev(dd);
> +	exit(EXIT_FAILURE);
>  }
>  
>  /* Request authentication */
> @@ -1995,24 +2064,31 @@ static void cmd_auth(int dev_id, int argc, char **argv)
>  	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
>  	if (!cr) {
>  		perror("Can't allocate memory");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	bacpy(&cr->bdaddr, &bdaddr);
>  	cr->type = ACL_LINK;
>  	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
>  		perror("Get connection info failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	if (hci_authenticate_link(dd, htobs(cr->conn_info->handle), 25000) < 0) {
>  		perror("HCI authentication request failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	free(cr);
>  
>  	hci_close_dev(dd);
> +
> +	return;
> +
> +failure:
> +	free(cr);
> +	hci_close_dev(dd);
> +	exit(EXIT_FAILURE);
>  }
>  
>  /* Activate encryption */
> @@ -2061,26 +2137,33 @@ static void cmd_enc(int dev_id, int argc, char **argv)
>  	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
>  	if (!cr) {
>  		perror("Can't allocate memory");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	bacpy(&cr->bdaddr, &bdaddr);
>  	cr->type = ACL_LINK;
>  	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
>  		perror("Get connection info failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	encrypt = (argc > 1) ? atoi(argv[1]) : 1;
>  
>  	if (hci_encrypt_link(dd, htobs(cr->conn_info->handle), encrypt, 25000) < 0) {
>  		perror("HCI set encryption request failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	free(cr);
>  
>  	hci_close_dev(dd);
> +
> +	return;
> +
> +failure:
> +	free(cr);
> +	hci_close_dev(dd);
> +	exit(EXIT_FAILURE);
>  }
>  
>  /* Change connection link key */
> @@ -2128,24 +2211,31 @@ static void cmd_key(int dev_id, int argc, char **argv)
>  	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
>  	if (!cr) {
>  		perror("Can't allocate memory");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	bacpy(&cr->bdaddr, &bdaddr);
>  	cr->type = ACL_LINK;
>  	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
>  		perror("Get connection info failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	if (hci_change_link_key(dd, htobs(cr->conn_info->handle), 25000) < 0) {
>  		perror("Changing link key failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	free(cr);
>  
>  	hci_close_dev(dd);
> +
> +	return;
> +
> +failure:
> +	free(cr);
> +	hci_close_dev(dd);
> +	exit(EXIT_FAILURE);
>  }
>  
>  /* Read clock offset */
> @@ -2194,19 +2284,19 @@ static void cmd_clkoff(int dev_id, int argc, char **argv)
>  	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
>  	if (!cr) {
>  		perror("Can't allocate memory");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	bacpy(&cr->bdaddr, &bdaddr);
>  	cr->type = ACL_LINK;
>  	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
>  		perror("Get connection info failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	if (hci_read_clock_offset(dd, htobs(cr->conn_info->handle), &offset, 1000) < 0) {
>  		perror("Reading clock offset failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	printf("Clock offset: 0x%4.4x\n", btohs(offset));
> @@ -2214,6 +2304,13 @@ static void cmd_clkoff(int dev_id, int argc, char **argv)
>  	free(cr);
>  
>  	hci_close_dev(dd);
> +
> +	return;
> +
> +failure:
> +	free(cr);
> +	hci_close_dev(dd);
> +	exit(EXIT_FAILURE);
>  }
>  
>  /* Read clock */
> @@ -2271,7 +2368,7 @@ static void cmd_clock(int dev_id, int argc, char **argv)
>  		cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
>  		if (!cr) {
>  			perror("Can't allocate memory");
> -			exit(1);
> +			goto failure;
>  		}
>  
>  		bacpy(&cr->bdaddr, &bdaddr);
> @@ -2279,7 +2376,7 @@ static void cmd_clock(int dev_id, int argc, char **argv)
>  		if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
>  			perror("Get connection info failed");
>  			free(cr);
> -			exit(1);
> +			goto failure;
>  		}
>  
>  		handle = htobs(cr->conn_info->handle);
> @@ -2293,7 +2390,7 @@ static void cmd_clock(int dev_id, int argc, char **argv)
>  
>  	if (hci_read_clock(dd, handle, which, &clock, &accuracy, 1000) < 0) {
>  		perror("Reading clock failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	accuracy = btohs(accuracy);
> @@ -2302,6 +2399,11 @@ static void cmd_clock(int dev_id, int argc, char **argv)
>  	printf("Accuracy: %.2f msec\n", (float) accuracy * 0.3125);
>  
>  	hci_close_dev(dd);
> +	return;
> +
> +failure:
> +	hci_close_dev(dd);
> +	exit(EXIT_FAILURE);
>  }
>  
>  static int read_flags(uint8_t *flags, const uint8_t *data, size_t size)
> @@ -2559,13 +2661,13 @@ static void cmd_lescan(int dev_id, int argc, char **argv)
>  						own_type, filter_policy, 10000);
>  	if (err < 0) {
>  		perror("Set scan parameters failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	err = hci_le_set_scan_enable(dd, 0x01, filter_dup, 10000);
>  	if (err < 0) {
>  		perror("Enable scan failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	printf("LE Scan ...\n");
> @@ -2573,16 +2675,21 @@ static void cmd_lescan(int dev_id, int argc, char **argv)
>  	err = print_advertising_devices(dd, filter_type);
>  	if (err < 0) {
>  		perror("Could not receive advertising events");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	err = hci_le_set_scan_enable(dd, 0x00, filter_dup, 10000);
>  	if (err < 0) {
>  		perror("Disable scan failed");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	hci_close_dev(dd);
> +	return;
> +
> +failure:
> +	hci_close_dev(dd);
> +	exit(EXIT_FAILURE);
>  }
>  
>  static struct option leinfo_options[] = {
> @@ -2654,7 +2761,7 @@ static void cmd_leinfo(int dev_id, int argc, char **argv)
>  			min_ce_length, max_ce_length, &handle, 25000);
>  	if (err < 0) {
>  		perror("Could not create connection");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	printf("\tHandle: %d (0x%04x)\n", handle, handle);
> @@ -2684,6 +2791,11 @@ static void cmd_leinfo(int dev_id, int argc, char **argv)
>  	hci_disconnect(dd, handle, HCI_OE_USER_ENDED_CONNECTION, 10000);
>  
>  	hci_close_dev(dd);
> +	return;
> +
> +failure:
> +	hci_close_dev(dd);
> +	exit(EXIT_FAILURE);
>  }
>  
>  static struct option lecc_options[] = {
> @@ -2757,12 +2869,17 @@ static void cmd_lecc(int dev_id, int argc, char **argv)
>  			min_ce_length, max_ce_length, &handle, 25000);
>  	if (err < 0) {
>  		perror("Could not create connection");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	printf("Connection handle %d\n", handle);
>  
>  	hci_close_dev(dd);
> +	return;
> +
> +failure:
> +	hci_close_dev(dd);
> +	exit(EXIT_FAILURE);
>  }
>  
>  static struct option lewladd_options[] = {
> @@ -3276,10 +3393,15 @@ static void cmd_ledc(int dev_id, int argc, char **argv)
>  	err = hci_disconnect(dd, handle, reason, 10000);
>  	if (err < 0) {
>  		perror("Could not disconnect");
> -		exit(1);
> +		goto failure;
>  	}
>  
>  	hci_close_dev(dd);
> +	return;
> +
> +failure:
> +	hci_close_dev(dd);
> +	exit(EXIT_FAILURE);
>  }
>  
>  static struct option lecup_options[] = {
> -- 
> 2.1.4
> 
