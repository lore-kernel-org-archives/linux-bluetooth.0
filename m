Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH BlueZ] shared/shell: Introduce bt_shell_{get,set}_env
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20180116192456.12186-1-luiz.dentz@gmail.com>
 <20180116192456.12186-2-luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <e8f6d900-7863-25f2-8a74-ed3d7a1e9e42@jp.fujitsu.com>
Date: Thu, 18 Jan 2018 14:35:29 +0900
MIME-Version: 1.0
In-Reply-To: <20180116192456.12186-2-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 01/17/2018 04:24 AM, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> These function can be used to share environment variable accross
> different files.
> ---
>  src/shared/shell.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/shell.h |  3 +++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index 6cdea1c7e..09f7896c6 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -56,6 +56,11 @@
>  
>  static GMainLoop *main_loop;
>  
> +struct bt_shell_env {
> +	char *name;
> +	void *value;
> +};
> +
>  static struct {
>  	struct io *input;
>  
> @@ -66,6 +71,8 @@ static struct {
>  	const struct bt_shell_menu *menu;
>  	const struct bt_shell_menu *main;
>  	struct queue *submenus;
> +
> +	struct queue *envs;
>  } data;
>  
>  static void shell_print_menu(void);
> @@ -759,6 +766,14 @@ static void rl_cleanup(void)
>  	rl_callback_handler_remove();
>  }
>  
> +static void env_destroy(void *data)
> +{
> +	struct bt_shell_env *env = data;
> +
> +	free(env->name);
> +	free(env);
> +}
> +
>  void bt_shell_run(void)
>  {
>  	struct io *signal;
> @@ -775,6 +790,11 @@ void bt_shell_run(void)
>  	g_main_loop_unref(main_loop);
>  	main_loop = NULL;
>  
> +	if (data.envs) {
> +		queue_destroy(data.envs, env_destroy);
> +		data.envs = NULL;
> +	}
> +
>  	rl_cleanup();
>  }
>  
> @@ -849,3 +869,46 @@ bool bt_shell_detach(void)
>  
>  	return true;
>  }
> +
> +static bool match_env(const void *data, const void *user_data)
> +{
> +	const struct bt_shell_env *env = data;
> +	const char *name = user_data;
> +
> +	return !strcmp(env->name, name);
> +}
> +
> +void bt_shell_set_env(const char *name, void *value)
> +{
> +	struct bt_shell_env *env;
> +
> +	if (!data.envs) {
> +		data.envs = queue_new();
> +		goto done;
> +	}
> +
> +	env = queue_remove_if(data.envs, match_env, (void *) name);
> +	if (env)
> +		env_destroy(env);
> +
> +done:
> +	env = new0(struct bt_shell_env, 1);
> +	env->name = strdup(name);
> +	env->value = value;
> +
> +	queue_push_tail(data.envs, env);
> +}
> +
> +void *bt_shell_get_env(const char *name)
> +{
> +	const struct bt_shell_env *env;
> +
> +	if (!data.envs)
> +		return NULL;
> +
> +	env = queue_find(data.envs, match_env, name);
> +	if (!env)
> +		return NULL;
> +
> +	return env->name;
> +}

I think that it is better to return the env or the env->value so that we
can use the env->value in a caller, otherwise this function shall return
boolean type because it checks if the passed name exist.


Regards,
Eramoto

> diff --git a/src/shared/shell.h b/src/shared/shell.h
> index 8b8b1f634..359629896 100644
> --- a/src/shared/shell.h
> +++ b/src/shared/shell.h
> @@ -87,4 +87,7 @@ int bt_shell_release_prompt(const char *input);
>  bool bt_shell_attach(int fd);
>  bool bt_shell_detach(void);
>  
> +void bt_shell_set_env(const char *name, void *value);
> +void *bt_shell_get_env(const char *name);
> +
>  void bt_shell_cleanup(void);
>

